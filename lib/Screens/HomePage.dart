
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
// import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
// import 'package:location/location.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

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
            onPressed: (){
              
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostTextPage()));  // for post images with caption

            },
            icon: const Icon(Icons.post_add),
          ),
          ActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostPage()));  // for post images with caption

            },
            // onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.insert_photo),
          ),
        ],
      ),
      body:_buildUI(size, postStory)
    );
  }
Widget _buildUI(Size size, PostStory postStory){
  return Container(
    height: size.height * 0.9,
    child:  StreamBuilder(
      stream: postStory.getStories(),
      builder: (context, dynamic snapshot) {
        print(snapshot.data);
        print('\$' * 30);
      if (!snapshot.hasData) {return SizedBox();}
      if (snapshot.connectionState == ConnectionState.waiting) {return SizedBox();}
   
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
           var docs = snapshot.data;
         
           print('@' * 20)
;          return Text(docs[index]['content']);
        },);


      

      // return CircularProgressIndicator();
    },),
    // child: ListView.builder(itemBuilder: (BuildContext context, index){
    //   // _pageProviderPost = context.watch<PostStory>();
    //   return Text('data');
    // },),
  );
}



// void _determinePosition() async {
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

_getCurrentLocation() {
    Geolocator
      .getCurrentPosition(forceAndroidLocationManager: true)
      .then((position) {
        if(mounted){
          setState(() {
          _currentPosition = position;
          print(_currentPosition!.latitude);
          print(_currentPosition!.longitude);
          print('ff'*200);
        });
        }
        GeoFirePoint center = geo.point(latitude: _currentPosition!.latitude, longitude: _currentPosition!.longitude);
        print(center);
        // _firestore.collection("location")
        print("T"*100);
      },
      ).catchError((e) {
        print(e);
      });
  }

}
 

 


