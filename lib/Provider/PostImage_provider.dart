import 'package:btech_project/Models/PostStory.dart';
import 'package:btech_project/Services/CloudServices.dart';
import 'package:btech_project/Services/DatabaseServices.dart';
import 'package:btech_project/Services/MediaServices.dart';
import 'package:btech_project/Services/NavigationServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
// import 'package:firebase/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class PostStory extends ChangeNotifier {
  DatabaseServices? _db;
  CloudStorageServices? _storage;
  UserRepository? _auth;

  final geo = Geoflutterfire();

  String? _storyText;
  String get story {
    return story;
  }

  var currentLocation;
  late GeoFirePoint _geoHash;
  GeoPoint get location => currentLocation;

  set story(String _value) {
    _storyText = _value;
  }

  PostStory(this._auth) {
    _db = GetIt.instance.get<DatabaseServices>();
    _storage = GetIt.instance.get<CloudStorageServices>();
    GeoHasher geoHasher = GeoHasher();

    Location.instance.hasPermission().then((value) {
      if (value == PermissionStatus.denied)
        Location.instance.requestPermission();
    });

    Location.instance.getLocation().then((value) {
      currentLocation = GeoPoint(value.latitude ?? 0, value.longitude ?? 0);
      //  _geoHash = geoHasher.encode(value.longitude!, value.latitude!);
      _geoHash =
          geo.point(latitude: value.latitude!, longitude: value.longitude!);
      notifyListeners();
      print(currentLocation.latitude);
      print("*(*)" * 10);
    });
    notifyListeners();
  }

  postMessage(_file) async {
    try {
      if (_file != null) {
        String? _dowanloadURL =
            await _storage?.saveUserImageToStorage(_auth!.user!.uuid, _file);
        PostStories _postStory = PostStories(
          content: _dowanloadURL!,
          name: _auth!.user!.name,
          senderID: _auth!.user!.uuid,
          sentTime: DateTime.now(),
          type: PostType.IMAGE,
          position: _geoHash.data,
        );
        _db!.addPost(_auth!.user!.uuid, _postStory);
      }
    } catch (e) {
      print(e);
    }
  }

  postText() async {
    if (_storyText != null) {
      PostStories _story = PostStories(
        content: _storyText!,
        senderID: _auth!.user!.uuid,
        name: _auth!.user!.name,
        sentTime: DateTime.now(),
        type: PostType.TEXT,
        position: _geoHash.data,
      );
      _db?.addPost(_auth!.user!.uuid, _story);
    }
  }

  getStories() {
    // Create a geoFirePoint
    GeoFirePoint center =
        geo.point(latitude: currentLocation.latitude, longitude: currentLocation.longitude);
        print(currentLocation.latitude);

// get the collection reference or query
    var collectionReference = FirebaseFirestore.instance.collection('Stories');

    double radius = 5;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);

    return stream;
  }
}
