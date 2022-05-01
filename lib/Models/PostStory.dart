import 'package:cloud_firestore/cloud_firestore.dart';

enum PostType {
  TEXT,
  IMAGE,
}

class PostStories {
  final String senderID;
  final PostType type;
  final String content;
  final DateTime sentTime;
  final String name;
  final  position;

  

  PostStories(
      {required this.type,
      required this.content,
      required this.senderID,
      required this.sentTime,
      required this.position,
      required this.name,
      });

  factory PostStories.fromJSON(Map<String, dynamic> _json) {
    PostType _postType;
    switch (_json["type"]) {
      
      case "text":
        _postType = PostType.TEXT;
        break;
      default:
        _postType = PostType.IMAGE;
    }
    return PostStories(
        type: _postType,
        content: _json["content"],
        senderID: _json["sender_id"],
        sentTime: _json["sent_time"].toDate(),
        position: _json["position"],
        name: _json["name"],
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
      "position": position,
      "name":name
    };
  }
}

