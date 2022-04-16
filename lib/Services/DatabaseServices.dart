import 'dart:ffi';

import 'package:btech_project/Models/Chat_message.dart';
import 'package:btech_project/Models/Chat_user.dart';
import 'package:btech_project/Models/PostStory.dart';
// import 'package:chat_system/Models/Chat_message.dart';
// import 'package:chat_system/Models/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = "users";
const String CHAT_COLLECTION = "Chats";
const String MESSAGE_COLLECTION = "messages";
const String POST_COLLECTION = "postStories";

class DatabaseServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;
   ChatUser? thisUser;
  ChatUser? getCurrentUser(){
    return thisUser;
  }
  Future<DocumentSnapshot> getUser(String _uid) {
      print('get User');
    
    return _db.collection(USER_COLLECTION).doc(_uid).get();
  }

  

  Future<void> addPost(String _uuid, PostStories _postStories) async {
    try {
      print('kkkkkk'*100);
      await _db
          // .doc(_uuid)
          .collection("Stories")
          .add(_postStories.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<QuerySnapshot> allUsers({String? name}) {
    print(_auth?.email);
    print('900'*100);
    Query _query = _db.collection('Stories');
     print(_auth?.email);
    return _query.get();
  }
  
  Future<QuerySnapshot> getUsers({String? name}) {
    print(_auth?.email);
    print('900'*100);
    Query _query = _db.collection(USER_COLLECTION).where("name",isNotEqualTo: _auth!.email);
     print(_auth!.email);
    if (name != null) {
      _query = _query
          .where("name", isGreaterThanOrEqualTo: name)
          .where("name", isLessThanOrEqualTo: name + "z");
    }
    return _query.get();
  }

  Stream<QuerySnapshot> getChatsForUser(String _uid) {
    return _db
        .collection(CHAT_COLLECTION)
        .where(
          'members',
          arrayContains: _uid,
        )
        .snapshots();

  }

  Future<QuerySnapshot> getLastMessageForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGE_COLLECTION)
        .orderBy("sent_time", descending: true)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> streamMessageForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGE_COLLECTION)
        .orderBy("sent_time", descending: false)
        .snapshots();
  }

  Future<void> addMessageToChat(String chatID, ChatMessage _message) async {
    try {
      await _db
          .collection(CHAT_COLLECTION)
          .doc(chatID)
          .collection(MESSAGE_COLLECTION)
          .add(_message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateChatData(
      String _chatID, Map<String, dynamic> _data) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).update(_data);
    } catch (e) {
      print(e);
    }
  }

  // Future<void> updateUserlastSeenTime(String _uid) async {
  //   try {
  //     await _db.collection(USER_COLLECTION).doc(_uid).update({
  //       "last_active": DateTime.now().toUtc(),
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> deleteChat(String _chatID) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentReference?> createChat(Map<String, dynamic> _data) async {
    try {
      DocumentReference _chat =
          await _db.collection(CHAT_COLLECTION).add(_data);
      return _chat;
    } catch (e) {
      print(e);
    }
  }
}
