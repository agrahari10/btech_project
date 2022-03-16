import 'dart:async';

import 'package:btech_project/Models/Chat_message.dart';
import 'package:btech_project/Services/DatabaseServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import '../Models/Chat.dart';
import '../Models/Chat_user.dart';

class ChatPageProvider extends ChangeNotifier {
  UserRepository _auth;
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  late DatabaseServices _db;

  List<Chat>? chats;

  late StreamSubscription _chatsStream;
  

  ChatPageProvider(
    this._auth,
  ) {
    _db = GetIt.instance.get<DatabaseServices>();
    getChats();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatsStream =
          _db.getChatsForUser(_auth.user.uuid).listen((_snapshot) async {
        chats = await Future.wait(
          _snapshot.docs.map(
            (_d) async {
              Map<String, dynamic> _chatData =
              _d.data() as Map<String, dynamic>;

              //get user in chat
              List<ChatUser> _members = [];
              for (var uuid in _chatData["members"]) {
                // print(_chatData["members"]);
                // print('()'*100);
                // if (currentUserId != _chatData["members"]) {
                print("%%%5"* 100);

                // if (_uid != currentUserId){
                DocumentSnapshot _userSnapshot = await _db.getUser(uuid);

                Map<String, dynamic> _userData =
                _userSnapshot.data()! as Map<String, dynamic>;
                _userData["uuid"] = _userSnapshot.id;
                print(_userData['uuid']);

                print(_userSnapshot.id);
                print('HHHHHH'*100);
                print(_userData);
                print(ChatUser.fromJSON(_userData));
                print('Hello'*100);
                _members.add(
                  ChatUser.fromJSON(_userData),
                );
                // print('^%'*500);
                // print(_userData);
                // }
              // }
            }
              // get Last Message  for Chat
              List<ChatMessage> _messages = [];
              QuerySnapshot _chatMessage =
                  await _db.getLastMessageForChat(_d.id);
              if (_chatMessage.docs.isNotEmpty) {
                Map<String, dynamic> _messageData =
                    _chatMessage.docs.first.data()! as Map<String, dynamic>;
                    ChatMessage _message = ChatMessage.fromJSON(_messageData);
                    _messages.add(_message);
              }
              return Chat(
                  uid: _d.id,
                  activity: _chatData["is_activity"],
                  members: _members,
                  currentUserid: _auth.user.uuid,
                  group: _chatData["is_group"],
                  message: _messages,
                  );
                
            },
          ).toList(),
        );
        notifyListeners();
        
      },);
    } catch (e) {
      print("Error getting chats");
      print(e);
    }
  }
}
