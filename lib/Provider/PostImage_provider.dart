
import 'package:btech_project/Models/PostStory.dart';
import 'package:btech_project/Services/CloudServices.dart';
import 'package:btech_project/Services/DatabaseServices.dart';
import 'package:btech_project/Services/MediaServices.dart';
import 'package:btech_project/Services/NavigationServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';



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

  var _currentLocation;
  GeoPoint get location => _currentLocation;


  void set story(String _value) {
    _storyText = _value;
    print(_storyText);
    print('^^'*100);
  }
  
  PostStory(this._auth) {
    _db = GetIt.instance.get<DatabaseServices>();
    _storage = GetIt.instance.get<CloudStorageServices>();
    _media = GetIt.instance.get<MediaServices>();
    _navigation = GetIt.instance.get<NavigationServices>();

    Location.instance.hasPermission().then((value) {
          if (value == PermissionStatus.denied)
          Location.instance.requestPermission();
        });
        
       Location.instance.getLocation().then((value) {
         _currentLocation = GeoPoint(value.latitude ?? 0, value.longitude ?? 0);
         notifyListeners();
         print(value);
         print("*(*)"*10);
       });
  }


   postMessage(_file) async {
    try {
      if (_file != null) {
        
        print(location);
        print("*#*"*100);
        String? _dowanloadURL =
            await _storage?.saveUserImageToStorage(_auth!.user!.uuid, _file);
        PostStories _postStory = PostStories(
            content: _dowanloadURL!,
            senderID: _auth!.user!.uuid,
            sentTime: DateTime.now(),
            type: PostType.IMAGE,
            location: _currentLocation,
            // location: GeoPoint(location.latitude, location.longitude),
            );
            _db!.addPost(_auth!.user!.uuid, _postStory);
      }
    } catch (e) { 
      print(e);
    }
  }


  postText()async {
    
    if (_storyText != null) {
      print('location '* 100);
      PostStories _story = PostStories(
          content: _storyText!,
          senderID: _auth!.user!.uuid,
          sentTime: DateTime.now(),
          type: PostType.TEXT,
          location: _currentLocation,
          );
      _db?.addPost(_auth!.user!.uuid, _story);
    }
  }  
}
