// import 'package:flutter/material.dart';

// class ChatUser {
//   // final String uid;
//   // final String name;
//   // final String email;
//   // final String imageURL;
//   // late DateTime lastActive;
//     late final String email;
//     final String password;
//     final String phoneNumber,
//     final String name,
//     final String address,
//     final String state,
//     final String country,
//     final File image,

//   ChatUser({
//     required this.uid,
//     required this.imageURL,
//     required this.email,
//     required this.lastActive,
//     required this.name,
//   });

//   factory ChatUser.fromJSON(Map<String, dynamic> _json) {
//     return ChatUser(
//         uid: _json["uid"],
//         imageURL: _json["image"],
//         email: _json["email"],
//         lastActive: _json["last_active"].toDate(),
//         // lastActive: DateTime.now(),
//         name: _json["name"]);
//   }
//   Map<String ,dynamic> toMap(){
//     return {
//       "email":email,
//       "Name" : name,
//       "lastActive":lastActive,
//       "Image" : imageURL,
//       "uid":uid
//   };
// }
// String lastActiveday(){
//     return "${lastActive.month}/${lastActive.day}/${lastActive.year}";

// }
// bool wasRecentlyActive(){
//     return DateTime.now().difference(lastActive).inMinutes < 10;
//   }
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ChatUser {
  final String uuid;
  final String name;
  final String email;
  final String photoUrl;
  late DateTime lastActive;
  final String address;
  final String phoneNumber;
  final String country;
  final String state;
  // Location location;
  // late DateTime joinDate;

  ChatUser({
    required this.uuid,
    required this.photoUrl,
    required this.email,
    required this.lastActive,
    required this.name,
    required this.address,
    required this.state,
    required this.country,
    required this.phoneNumber,
    // required this.location,
  });

  factory ChatUser.fromJSON(Map<String, dynamic> _json) {
    return ChatUser(
        uuid: _json["uuid"],
        address: _json["address"],
        state: _json["state"],
        country: _json["country"],
        phoneNumber: _json["phoneNumber"],
        photoUrl: _json["photoUrl"],
        email: _json["email"],
        lastActive: _json["last_active"].toDate(),
        // lastActive: DateTime.now(),
        name: _json["name"]);
        // location: _json["location"].location.data());
  }
  Map<String ,dynamic> toMap(){
    return {
      "email":email,
      "Name" : name,
      "lastActive":lastActive,
      "photoUrl" : photoUrl,
      "uuid":uuid,
      "phoneNUmber":phoneNumber,
      "country":country,
      "address":address,
      "state":state,

  };
}
String lastActiveday(){
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";

}
bool wasRecentlyActive(){
    return DateTime.now().difference(lastActive).inMinutes < 2;
  }

}