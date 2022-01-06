import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AppState {
  initial,
  authenticated,
  authenticating,
  unauthenticated,
  unauthorised,
}

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  var _user;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final GoogleSignIn _googleSignIn;
  AppState _appState = AppState.initial;

  AppState get appState => _appState;
  get user => _user;

  UserRepository() : _auth = FirebaseAuth.instance {
    print('*' * 100);
    print('user repository initialised');
    print('*' * 100);
    // _appState = AppState.unauthenticated;

    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _appState = AppState.unauthenticated;
        notifyListeners();
      } else {
        print('logged In');
        _user = firebaseUser;

        _appState = AppState.authenticated;
        notifyListeners();
        // var value = await _firestore
        //     .collection('users')
        //     .doc(FirebaseAuth.instance.currentUser?.uid)
        //     .get();
        // print('*' * 100);
        // print(value.data());
        // print('*' * 100);
        // if (value.data()?['isRequestAccepted'] == 'accepted') {
        //   _appState = AppState.authenticated;
        //   notifyListeners();
        // } else {
        //   _appState = AppState.unauthorised;
        //   notifyListeners();
        // }
        // print('*' * 200);
        // print(data);
        // print('*' * 200);
      }
    });
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // Function to get the user and userId
  // Future<String> getUser() async {
  //   return (await _firebaseAuth.currentUser).uid;
  // }

  Future<bool> isFirstTime(String userId) async {
    bool exist = false;
    await _firestore.collection('users').doc(userId).get().then((var user) {
      exist = user.exists;
    }).catchError((error) {
      exist = true;
    });

    return exist;
  }

  Future<dynamic> login(String email, String password) async {
    // try {
    // _appState = AppState.authenticating; //set current state to loading state.
    // notifyListeners();

    var user = await _auth
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
    // }
    //  catch (e) {
    //   print(e.toString() + '*******');
    //   _appState = AppState.unauthenticated;
    //   notifyListeners();
    //   throw e;
    // }
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
    var user = await _auth.createUserWithEmailAndPassword(
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
      'joinDate': Timestamp.now(),
      // 'isRequestAccepted': 'pending', // pending, accepted, rejected
      // 'wins': 0,
      // 'participated': 0,
      // 'isAdmin': false,
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
    await _auth.signOut();

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

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).update({
      'name': name,
      'address': address,
      'state': state,
      'country': country,
      'phoneNumber': phoneNumber,
      'photoUrl': imageUrl,
    });
  }
}
// }
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/widgets.dart';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }
//
// class UserRepository with ChangeNotifier {
//   FirebaseAuth _auth;
//   var _user;
//   Status _status = Status.Uninitialized;
//
//   UserRepository.instance() : _auth = FirebaseAuth.instance {
//     _auth.authStateChanges().listen(_onAuthStateChanged);
//   }
//
//   Status get status => _status;
//   get user => _user;
//
//   Future<bool> signIn(String email, String password) async {
//     try {
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       return false;
//     }
//   }
//
//   Future signOut() async {
//     _auth.signOut();
//     _status = Status.Unauthenticated;
//     notifyListeners();
//     return Future.delayed(Duration.zero);
//   }
//
//   Future<void> _onAuthStateChanged(firebaseUser) async {
//     if (firebaseUser == null) {
//       _status = Status.Unauthenticated;
//     } else {
//       _user = firebaseUser;
//       _status = Status.Authenticated;
//     }
//     notifyListeners();
//   }
// }