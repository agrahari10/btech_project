// import 'dart:io' as File;
// import 'dart:html' as File;

import 'package:btech_project/Models/PostStory.dart';
import 'package:btech_project/Services/CloudServices.dart';
import 'package:btech_project/Services/DatabaseServices.dart';
import 'package:btech_project/Services/MediaServices.dart';
import 'package:btech_project/Services/NavigationServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class PostStory extends ChangeNotifier {
  DatabaseServices? _db;
  CloudStorageServices? _storage;
  UserRepository? _auth;
  MediaServices? _media;
  NavigationServices? _navigation;

  String? _storyText;
  String get story {
    return story;
  }

  void set story(String _value) {
    _storyText = _value;
  }
  
  PostStory(this._auth) {
    _db = GetIt.instance.get<DatabaseServices>();
    _storage = GetIt.instance.get<CloudStorageServices>();
    _media = GetIt.instance.get<MediaServices>();
    _navigation = GetIt.instance.get<NavigationServices>();
  }

   postMessage(_file) async {
    try {
      if (_file != null) {
        String? _dowanloadURL =
            await _storage?.saveUserImageToStorage(_auth!.user.uuid, _file);
        PostStories _postStory = PostStories(
            content: _dowanloadURL!,
            senderID: _auth!.user.uuid,
            sentTime: DateTime.now(),
            type: PostType.IMAGE);
            _db!.addPost(_auth!.user.uuid, _postStory);
      }
    } catch (e) {
      print(e);
    }
  }


  void sendTextMessage() {
    print(_storyText);
    if (_storyText != null) {
      PostStories _story = PostStories(
          content: _storyText!,
          senderID: _auth!.user.uuid,
          sentTime: DateTime.now(),
          type: PostType.TEXT);
      _db?.addPost(_auth!.user.uuid, _story);
    }
  }

  // Future<Position> getCurrentLocation() async {
  //   Position _currentLocation;
  //   var position = await GeolocatorPlatform.instance
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //   // final Geolocator geolocator = Geolocator().forceAndroidLocationManager;
  //   // await geolocator
  //   //     .getCurrentPosition(
  //   //     desiredAccuracy: LocationAccuracy.best,
  //   //     locationPermissionLevel: GeolocationPermission.locationWhenInUse)
  //   //     .then((Position position) {
  //   //   _currentLocation = position;
  //   });
  //   return _currentLocation;
  }

