// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

const String USER_COLLECTION = "users";
class CloudStorageServices{
  
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CloudStorageServices(){}
    int i = 0; // count no of posts of users 
  Future<String?> saveChatImageToStorage(String _chatID,String _userID,PlatformFile _file)async{
    // File file = File(filePath);
    try{
      Reference _ref = _storage.ref().child('images/chats/$_chatID/$_userID/${Timestamp.now().millisecondsSinceEpoch}.${_file.extension}');
      

      // ignore: unused_local_variable
      UploadTask _task = _ref.putFile(File(_file.path.toString()),);
      return await _task.then((_result) => _result.ref.getDownloadURL());
    }
    catch(e){
      print(e);
    }

  }
   Future<String?> saveUserImageToStorage(String _userID,PickedFile _file)async{
    try{
      Reference _ref = _storage.ref().child('Postimages/$_userID/${Timestamp.now().millisecondsSinceEpoch}');
      

      // ignore: unused_local_variable
      UploadTask _task = _ref.putFile(File(_file.path.toString()),);
      return await _task.then((_result) => _result.ref.getDownloadURL());
    }
    catch(e){
      print(e);
    }

  }
}