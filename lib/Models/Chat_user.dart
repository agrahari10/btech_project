

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
        name: _json["name"]);
        
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
    return DateTime.now().difference(lastActive).inMinutes < 5;
  }

}