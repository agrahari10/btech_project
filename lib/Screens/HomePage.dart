import 'package:btech_project/Provider/PostImage_provider.dart';
import 'package:btech_project/Screens/TextPost.dart';
import 'package:btech_project/Screens/postStrories.dart';
import 'package:btech_project/Screens/postsection.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
// import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
// import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? _serviceEnabled;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  final geo = Geoflutterfire();
  double radius = 5;
  var min = 1;
  var max = 10;
  @override
  void initState() {
    // print('()(1)'*100);
    // _determinePosition();
    // getCurrentLocation();
  }

  // late PostStory _pageProviderPost;
  Position? _currentPosition;
  Position? currentPosition;
  String? _currentAddress;
  Random random = Random();
  // Permission

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserRepository _auth = Provider.of<UserRepository>(context);
    PostStory postStory = Provider.of<PostStory>(context);
    return Scaffold(
        floatingActionButton: ExpandableFab(
          distance: 112.0,
          children: [
            ActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PostTextPage())); // for post images with caption
              },
              icon: const Icon(Icons.post_add),
            ),
            ActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PostPage())); // for post images with caption
              },
              // onPressed: () => _showAction(context, 1),
              icon: const Icon(Icons.insert_photo),
            ),
          ],
        ),
        body: _buildUI(size, postStory));
  }

  Widget _buildUI(Size size, PostStory postStory) {
    return Container(
      height: size.height * 0.9,
      child: StreamBuilder(
        stream: postStory.currentLocation == null ? null : postStory.getStories(),
        builder: (context, dynamic snapshot) {
          
          print('\$' * 30);
          if (!snapshot.hasData) {
            return SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var docs = snapshot.data;
              print('@' * 20);
              
              if (  docs[index]['type'] == "text") {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Container(
                    height: size.height * 0.35,
                    width: size.width * 0.75,
              
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff141e30),
                Color(0xff243b55)
              ],
            ),
                      border: Border.all(
                          color: const Color(0xFF000000),
                          width: 2.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        docs[index]['content'].toString().toUpperCase(),
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white.withOpacity(1.0),
                            // height: ,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );
              }
              if (docs[index]['type'] == "image") {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Container(
                    height: size.height * 0.35,
                    width: size.width * 0.75,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF000000),
                            width: 2.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(docs[index]['content']),
                            ),
                            ),
                  ),
                );
              }
              // return Text(docs[index]['content']);
              return CircularProgressIndicator();
            },
          );

          // return CircularProgressIndicator();
        },
      ),
      // child: ListView.builder(itemBuilder: (BuildContext context, index){
      //   // _pageProviderPost = context.watch<PostStory>();
      //   return Text('data');
      // },),
    );
  }

  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(forceAndroidLocationManager: true).then(
  //     (position) {
  //       if (mounted) {
  //         setState(() {
  //           _currentPosition = position;
  //           print(_currentPosition!.latitude);
  //           print(_currentPosition!.longitude);
  //           print('ff' * 200);
  //         });
  //       }
  //       GeoFirePoint center = geo.point(
  //           latitude: _currentPosition!.latitude,
  //           longitude: _currentPosition!.longitude);
  //       print(center);
  //       // _firestore.collection("location")
  //       print("T" * 100);
  //     },
  //   ).catchError((e) {
  //     print(e);
  //   });
  // }
}
