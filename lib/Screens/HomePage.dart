import 'package:btech_project/Provider/PostImage_provider.dart';
import 'package:btech_project/Screens/postStrories.dart';
import 'package:btech_project/Screens/postsection.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
//

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // Location location = new Location();
//   // LocationData? _currentPosition;
//   // // GeoCode geoCode = GeoCode();
//   // static const _actionTitles = [ 'Post only Text','Post With caption'];



//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // getLoc();
//   }

//   Widget build(BuildContext context) {
//     final _userRepository = Provider.of<UserRepository>(context);
//     Size size = MediaQuery.of(context).size;
//     scaffold = 
//   }

  // getLoc() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // final LocationData position = await location.getLocation();

    // print(position.latitude);
    // print(position.longitude);
    // print("*" * 100);
    //   _currentPosition = await location.getLocation();
    //   _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    //   location.onLocationChanged.listen((LocationData currentLocation) {
    //     print("${currentLocation.longitude} : ${currentLocation.longitude}");
    //     setState(() {
    //       _currentPosition = currentLocation;
    //       _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    //
    //       DateTime now = DateTime.now();
    //       _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
    //       _getAddress(_currentPosition.latitude, _currentPosition.longitude)
    //           .then((value) {
    //         setState(() {
    //           _address = "${value.first.addressLine}";
    //         });
    //       });
    //     });
    //   });
    // }
  // }
  //
  // _getCurrentLocation() {
  //   Geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
// }


// @immutable
// class ExpandableFab extends StatefulWidget {
//   const ExpandableFab({
//     Key? key,
//     this.initialOpen,
//     required this.distance,
//     required this.children,
//   }) : super(key: key);

//   final bool? initialOpen;
//   final double distance;
//   final List<Widget> children;

//   @override
//   _ExpandableFabState createState() => _ExpandableFabState();
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // PostStorys? _postStoryProvider;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // UserRepository _auth = Provider.of<UserRepository>(context);
    return Scaffold(

      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: (){

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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, int index) {
          // _postStoryProvider = context.watch<PostStorys>();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.35,
              child: Column(
                children: [
                  // CarouselSlider(
                  //   items: [
                  //     //1st Image of Slider
                  //     Container(
                  //       margin: EdgeInsets.all(6.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10.0),
                  //         image: DecorationImage(
                  //           image: AssetImage('images/one.jpeg'),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),

                  //     //2nd Image of Slider
                  //     Container(
                  //       margin: EdgeInsets.all(6.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //         image: DecorationImage(
                  //           image: AssetImage('images/two.jpeg'),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),

                  //     //3rd Image of Slider
                  //     Container(
                  //       margin: EdgeInsets.all(6.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //         image: DecorationImage(
                  //           image: AssetImage('images/three.jpeg'),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),

                  //     //4th Image of Slider
                  //     Container(
                  //       margin: EdgeInsets.all(6.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //         image: DecorationImage(
                  //           image: AssetImage('images/four.jpeg'),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),

                  //     //5th Image of Slider
                  //     Container(
                  //       margin: EdgeInsets.all(6.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //         image: DecorationImage(
                  //           image: AssetImage('images/four.jpeg'),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //   ],

                  //   //Slider Container properties
                  //   options: CarouselOptions(
                  //     height: 200,
                  //     enlargeCenterPage: true,
                  //     autoPlay: true,
                  //     aspectRatio: 16 / 9,
                  //     autoPlayCurve: Curves.fastOutSlowIn,
                  //     enableInfiniteScroll: true,
                  //     autoPlayAnimationDuration: Duration(milliseconds: 800),
                  //     viewportFraction: 0.9,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: size.height * 0.03),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetaur temporbksnknka incididunt ut labore et dolore magna aliqua. ...more '),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}