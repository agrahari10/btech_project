import 'package:btech_project/Page/Calling.dart';
import 'package:btech_project/Page/chat.dart';
import 'package:btech_project/Page/profile.dart';
import 'package:btech_project/Screens/ChatPage.dart';
import 'package:btech_project/Screens/ChatUserPage.dart';
import 'package:btech_project/Screens/Chat_Screen.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ChatsPage(),
    UsersPage(),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                Icons.supervised_user_circle,
                color: Colors.blueGrey
            ),
            label: 'Users',
            activeIcon: Icon(
              Icons.supervised_user_circle,
              color: Colors.black12,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit,
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
          if(mounted){
            setState(() {
            _selectedIndex = index;
          });
          }
          

        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

}