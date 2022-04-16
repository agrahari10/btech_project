// import 'dart:async';

// // import 'package:LocalStory/model/story_model.dart';
// import 'package:btech_project/Models/PostStory.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:geolocator/geolocator.dart';

// class StoryProvider with ChangeNotifier {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Position? _currentPosition;
//   Position? currentPosition;
//   String? _currentAddress;



//   Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the 
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale 
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
  
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately. 
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   } 

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return _getCurrentLocation();
// }

// _getCurrentLocation() async {
//     await Geolocator 
//       .getCurrentPosition(forceAndroidLocationManager: true)
//       .then((position) {
//           _currentPosition = position;
//           print(_currentPosition!.latitude);
//           print(_currentPosition!.longitude);
//           print('ff'*200);
//         });
//         return _currentPosition;
//         }
//       //   GeoFirePoint center = geo.point(latitude: _currentPosition!.latitude, longitude: _currentPosition!.longitude);
//       //   print(center);
//       //   // _firestore.collection("location")
//       //   print("T"*100);
//       // },
//   //     ).catchError((e) {
//   //       print(e);
//   //     });
//   // }

//   // Future<Position> getCurrentLocation() async {
//   //   Position _currentLocation;
//   //   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//   //   await geolocator
//   //       .getCurrentPosition(
//   //           desiredAccuracy: LocationAccuracy.best,
//   //           locationPermissionLevel: GeolocationPermission.locationWhenInUse)
//   //       .then((Position position) {
//   //     _currentLocation = position;
//   //   });
//   //   return _currentLocation;
//   // }
//   // Stream<List<StoryModel>> get stories {
//   //   return _firestore
//   //       .collection('stories')
//   //       .orderBy('createdAt', descending: true)
//   //       .snapshots()
//   //       .map(_storyListFromSnanshot);
//   // }



//   // List<StoryModel> _storyListFromDocumentSnanshot(DocumentSnapshot snapshot) {
//   //   return snapshot.data();
//   // }

  

//   // Future<Stream<List<DocumentSnapshot>>> get getNearbyStories async {
//   //   // Init firestore and geoFlutterFire
//   //   final geo = Geoflutterfire();
//   //   Position currentPostion = await getCurrentLocation();
//   //   GeoFirePoint center = geo.point(
//   //       latitude: currentPostion.latitude, longitude: currentPostion.longitude);

//   //   var collectionReference = _firestore.collection('stories');

//   //   double radius = 10.0;
//   //   String field = 'location';

//   //   var stream = geo
//   //       .collection(collectionRef: collectionReference)
//   //       .within(center: center, radius: radius, field: field);
//   //   return stream;
//   //   // return stream.listen((List<DocumentSnapshot> docs) {
//   //   //   // docs.map(_storyListFromDocumentSnanshot);
//   //   //   docs.map((doc) {
//   //   //     var data = doc.data();
//   //   //     return StoryModel(
//   //   //       createdAt: data['createdAt'],
//   //   //       senderName: data['senderName'],
//   //   //       story: data['story'],
//   //   //       type: data['type'],
//   //   //     );
//   //   //   });
//   //   // });
//   // }
// }

// // class [ {
// // }