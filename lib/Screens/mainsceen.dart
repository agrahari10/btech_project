import 'package:btech_project/Page/Calling.dart';
import 'package:btech_project/Page/chat.dart';
import 'package:btech_project/Page/profile.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   final List<Widget> introWidgetsList = <Widget>[
//     // Screen1(...),
//     // Screen2(...),
//     // Screen3(...),
//     Text('dddd'),
//   ];
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   final List _Page = [
//     HomePage(),
//     Call(),
//     // ProfilePage(),
//     Chat()
//
//   ];
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back),
//           color: Colors.black,
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 // title: Text('Home'),
//                 label: 'Home',
//                 backgroundColor: Colors.black12),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.phone),
//                 // title: Text('Call'),
//                 label: 'Call',
//                 backgroundColor: Colors.black12),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat),
//               // title: Text('Chat'),
//               label: 'Chat',
//
//               backgroundColor: Colors.black12,
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Person',
//
//                 // title: Text('Profile'),
//                 backgroundColor: Colors.black12),
//           ],
//           type: BottomNavigationBarType.shifting,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.black,
//           iconSize: 40,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           elevation: 5),
//       body:_Page[_selectedIndex]
//     );
//   }
// }
// // }
// //
// // Widget circleBar(bool isActive) {
// //   return AnimatedContainer(
// //     duration: Duration(milliseconds: 150),
// //     margin: EdgeInsets.symmetric(horizontal: 8),
// //     height: isActive ? 12 : 8,
// //     width: isActive ? 12 : 8,
// //     decoration: BoxDecoration(
// //         color: isActive ? Colors.red : Colors.grey,
// //         borderRadius: BorderRadius.all(Radius.circular(12))),
// //   );
// // }
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Chat(),
    Call(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final _userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () async{
                await _userRepository.logout();
              },
              icon: Icon(Icons.logout),
              color: Colors.black,
            ),
          ],
        ),


      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blueGrey,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              color: Colors.black12,

            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_sharp,
              color: Colors.blueGrey
            ),
            label: 'Chat',
            activeIcon: Icon(
              Icons.chat_sharp,
              color: Colors.black12,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.phone,
                color: Colors.blueGrey
            ),
            label: 'Chat',
            activeIcon: Icon(
              Icons.phone,
              color: Colors.black12,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.blueGrey,
              size: 30,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person,
              color: Colors.black12,
              size: 30,
            ),
          ),

        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

}