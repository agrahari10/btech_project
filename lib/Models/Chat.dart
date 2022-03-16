import 'package:btech_project/Models/Chat_message.dart';
import 'package:flutter/material.dart';

import 'Chat_user.dart';

class Chat {
  final String uid;
  final String currentUserid;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> message;
  late final List<ChatUser> _recepients;

  Chat({
    required this.uid,
    required this.activity,
    required this.members,
    required this.currentUserid,
    required this.group,
    required this.message,
  }) {
    _recepients = members.where((_i) => _i.uuid != currentUserid).toList();
  }
  List<ChatUser> recepients() {
    // print(_recepients);
    // print('recepients');
    // print('*'*100);
    return _recepients;
  }

  String title() {
    return !group
        ? _recepients.first.name
        : _recepients.map((_user) => _user.name).join(",");
  }


  String imageeUrl() {
    return !group
        ? _recepients.first.photoUrl
        : "https://htmlcolorcodes.com/assets/images/colors/red-color-solid-background-1920x1080.png";
  }
// String imageeUrl(){
//     if(group){
//       return "https://htmlcolorcodes.com/assets/images/colors/red-color-solid-background-1920x1080.png";}
//     else{
//       return "https://htmlcolorcodes.com/assets/images/colors/red-color-solid-background-1920x1080.png";
//     }
//     }
}

