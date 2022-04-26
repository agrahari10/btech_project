import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

enum PostType {
  TEXT,
  IMAGE,
}

class PostStories {
  final String senderID;
  final PostType type;
  final String content;
  final DateTime sentTime;
  // final String location;

  final location;

  

  PostStories(
      {required this.type,
      required this.content,
      required this.senderID,
      required this.sentTime,
      required this.location
      });

  factory PostStories.fromJSON(Map<String, dynamic> _json) {
    PostType _postType;
    switch (_json["type"]) {
      
      case "text":
        _postType = PostType.TEXT;
        break;
      // case "image":
      //   _postType = PostType.IMAGE;
      //   break;
      default:
        _postType = PostType.IMAGE;
    }
    return PostStories(
        type: _postType,
        content: _json["content"],
        senderID: _json["sender_id"],
        sentTime: _json["sent_time"].toDate(),
        location: _json["location"]
        );
  }
  Map<String, dynamic> toJson() {
    // print(location);
    print('*' * 30);
    String _postType;
    switch (type) {
      case PostType.TEXT:
        _postType = "text";
        break;
      case PostType.IMAGE:
        _postType = "image";
        break;
    }
    // print(type);
    return {
      "content": content,
      "type": _postType,
      "sender_id": senderID,
      "sent_time": Timestamp.fromDate(sentTime),
      "location": location,
    };
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// class StoryModel {
//   final Timestamp createdAt;
//   final String senderName;
//   final String story;
//   final String type;

//   StoryModel({required this.createdAt,required this.senderName,required this.story,required this.type});
// }