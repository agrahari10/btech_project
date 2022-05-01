import 'package:btech_project/Models/Chat.dart';
import 'package:btech_project/Models/Chat_user.dart';
import 'package:btech_project/Screens/ChatPage.dart';
import 'package:btech_project/Services/DatabaseServices.dart';
import 'package:btech_project/Services/NavigationServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UsersPageProvider extends ChangeNotifier {
  UserRepository _auth;
  DatabaseServices? _database;
  NavigationServices? _navigation;

  List<ChatUser>? users;
  late List<ChatUser> _selectedUsers;

  List<ChatUser> get selectedUsers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    _database = GetIt.instance.get<DatabaseServices>();
    _navigation = GetIt.instance.get<NavigationServices>();
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUsers({String? name}) async {
    _selectedUsers = [];
    try {
      _database!.getUsers(name: name).then((_snapshot) {
        users = _snapshot.docs.map((_doc) {
          Map<String, dynamic> _data = _doc.data() as Map<String, dynamic>;
          _data["uid"] = _doc.id;
          return ChatUser.fromJSON(_data);
        }).toList();
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  void updateSelectedUsers(ChatUser _user) {
    if (_selectedUsers.contains(_user)) {
      _selectedUsers.remove(_user);
    } else {
      _selectedUsers.add(_user);
    }
    notifyListeners();
  }

  void createChat() async { // adding chat 
    try {
      List<String> _membersIds =
          _selectedUsers.map((_user) => _user.uuid).toList();
      _membersIds.add(_auth.user!.uuid);
      bool _isGroup = _selectedUsers.length > 1;
      DocumentReference? doc = await _database!.createChat({
        "is_group": _isGroup,
        "is_activity": false,
        "members": _membersIds,
      });
      List<ChatUser> _members = [];
      for (var _uid in _membersIds) {
        // if ( )
        DocumentSnapshot _userSnapShot = await _database!.getUser(_uid);
        Map<String, dynamic> _userData =
            _userSnapShot.data() as Map<String, dynamic>;
        _userData["uid"] = _userSnapShot.id;
        _members.add(ChatUser.fromJSON(_userData));
      }
      ChatPage _chatPage = ChatPage(  // Screens Chat Page....
        chat: Chat(
            uid: doc!.id,
            activity: false,
            members: _members,
            currentUserid: _auth.user!.uuid,
            group: _isGroup,
            message: []),
      );
      _selectedUsers = [];
      notifyListeners();
      _navigation!.navigateToPage(_chatPage);
    } catch (e) {
      print(e);
    }
  }
}
