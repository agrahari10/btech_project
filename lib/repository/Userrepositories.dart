import 'dart:io';
import 'package:btech_project/Models/Chat_message.dart';
import 'package:btech_project/Models/Chat_user.dart';
import 'package:btech_project/Services/DatabaseServices.dart';
import 'package:btech_project/Services/NavigationServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';


enum AppState {
  initial,
  authenticated,
  authenticating,
  unauthenticated,
  unauthorised,
}

class UserRepository with ChangeNotifier {
  late final NavigationServices _navigationServices;
  late final DatabaseServices _databaseServices;
  FirebaseAuth? _auth;
  var _user;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late ChatUser user; 


  // final GoogleSignIn _googleSignIn;
  AppState _appState = AppState.initial;

  AppState get appState => _appState;
  // get usser => _user;
  FirebaseAuth? get usser{
    print(_auth);
    print("**^&^"*100);
    return _auth;
  }

  UserRepository(){
    _auth = FirebaseAuth.instance;
    _navigationServices = GetIt.instance.get<NavigationServices>();
    _databaseServices = GetIt.instance<DatabaseServices>();
    print('*' * 100);
    print('user repository initialised');
    print('*' * 100);
    print(_auth);
    print("--0"*100);
    // _appState = AppState.unauthenticated;

    _auth!.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _appState = AppState.unauthenticated;

        notifyListeners();
      } else {
        print('logged In');
        // _user = firebaseUser;
        print("auth state changed");
        _databaseServices.updateUserlastSeenTime(firebaseUser.uid);
        _databaseServices.getUser(firebaseUser.uid).then(
          (_snapshot) {
            print(_snapshot.data());
            if (_snapshot.data()!= null){
              Map<String, dynamic> _userData =
                _snapshot.data() as Map<String, dynamic>;
            print("??" * 20);
            print(_userData);

            print("&&" * 20);
            // print(_userData.containsKey("last_active"));
            user = ChatUser.fromJSON(
              {
                "uuid": firebaseUser.uid,
                "name": _userData["name"],
                "email": _userData["email"],
                "last_active": _userData["last_active"],
                "photoUrl": _userData["photoUrl"],
                // "joinDate":_userData["joinDate"],
                "phoneNumber":_userData["phoneNumber"],
                "state":_userData["state"],
                "country":_userData["country"],
                "address":_userData["address"],
              },
            );
            print('&' * 100);
            print(user.toMap());
            // _navigationServices.removAndNavigateToRoute('/home'); //  naviate to home after login
          }

            }
            
        );
        print('%' * 100);
        print('User loggedIN');
        // print(user.toMap());

        _appState = AppState.authenticated;
        notifyListeners();
      }
    });
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }


  Future<dynamic> login(String email, String password) async {
    var user = await _auth!
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      print(error.code);
      _appState = AppState.unauthenticated;
      notifyListeners();

      throw error;
    });

    _appState = AppState.authenticated;
    notifyListeners();
    return user;
  }

  Future<dynamic> signup({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
    required String address,
    required String state,
    required String country,
    required File image,
  }) async {
    _appState = AppState.authenticating;
    var user = await _auth!.createUserWithEmailAndPassword(
        email: email, password: password);

    // upload photo to firebase storage

    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      'email': email,
      'address': address,
      'state': state,
      'country': country,
      'photoUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'uuid': FirebaseAuth.instance.currentUser!.uid,
      // 'joinDate': Timestamp.now(),
      "last_active": DateTime.now().toUtc(),
    }).catchError((error) {
      _appState = AppState.unauthenticated;
      notifyListeners();

      throw error;
    }).then((value) {
      _appState = AppState.authenticated;
      notifyListeners();
    });
  }

  Future logout() async {
    await _auth!.signOut();

    _appState = AppState.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<dynamic> getCurrentUserDetails() async {
    var _user = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return _user;
  }

  Future<void> updateUserProfile({
    required String name,
    required String phoneNumber,
    required String address,
    required String state,
    required String country,
    required File image,
  }) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    await _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).update({
      'name': name,
      'address': address,
      'state': state,
      'country': country,
      'phoneNumber': phoneNumber,
      'photoUrl': imageUrl,
    });
  }

  // Future<DocumentSnapshot> getUser(String _uid) {  // get users for all users 
  //    print(_auth);
  //     print("7"*100);
  //    // DocumentSnapshot document = _db.collection(USER_COLLECTION).doc(_uid).get();
  //    // if {

  //    // }
  //   return _firestore.collection('users').doc(_uid).get();
  // }


  // Future<QuerySnapshot> getUsers({String? name}) { // search name function 
  //   // print(_auth!.email); 
  //   print('900'*100);
  //   Query _query = _firestore.collection('users').where("name",isNotEqualTo: _auth);
  //   //  print(_auth!.email);
  //   if (name != null) {
  //     _query = _query
  //         .where("name", isGreaterThanOrEqualTo: name)
  //         .where("name", isLessThanOrEqualTo: name + "z");
  //   }
  //   return _query.get();
  // }

  // Stream<QuerySnapshot> getChatsForUser(String _uid) {
  //   // print('object'*100);
  //   // print(_db
  //   //     .collection(CHAT_COLLECTION)
  //   //     .where('members', arrayContains: _uid)
  //   //     .snapshots());
  //   return _firestore
  //       .collection('users')
  //       .where(
  //         'members',
  //         // isNotEqualTo: _auth!.email,
  //         arrayContains: _uid,
  //       )
  //       .snapshots();

  // }
  //  Future<QuerySnapshot> getLastMessageForChat(String _chatID) { // last message in chat list
  //   return _firestore
  //       .collection('users')
  //       .doc(_chatID)
  //       .collection('MESSAGE_COLLECTION')        
  //       .orderBy("sent_time", descending: true)
  //       .limit(1)
  //       .get();
  // }
  // Stream<QuerySnapshot> streamMessageForChat(String _chatID) { // Message list stream user to user
  //   return _firestore 
  //       .collection('users')
  //       .doc(_chatID)
  //       .collection('MESSAGE_COLLECTION')
  //       .orderBy("sent_time", descending: false)
  //       .snapshots();
  // }

  //  Future<void> addMessageToChat(String chatID, ChatMessage _message) async {
  //   try {
  //     await _firestore
  //         .collection('users')
  //         .doc(chatID)
  //         .collection('MESSAGE_COLLECTION')
  //         .add(_message.toJson());
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> updateChatData(
  //     String _chatID, Map<String, dynamic> _data) async {
  //   try {
  //     await _firestore.collection('users').doc(_chatID).update(_data);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // Future<void> deleteChat(String _chatID) async {
  //   try {
  //     await _firestore.collection('users').doc(_chatID).delete();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<DocumentReference?> createChat(Map<String, dynamic> _data) async {
  //   try {
  //     DocumentReference _chat =
  //         await _firestore.collection('users').add(_data);
  //     return _chat;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}

 