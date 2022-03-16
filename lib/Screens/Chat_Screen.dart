import 'package:btech_project/Models/Chat.dart';
import 'package:btech_project/Models/Chat_user.dart';
import 'package:btech_project/Provider/ChatPage_Provider.dart';
import 'package:btech_project/Screens/ChatPage.dart';
import 'package:btech_project/Services/NavigationServices.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/CustomList_tile.dart';
import 'package:btech_project/widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../Models/Chat_message.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late UserRepository _auth;
  late ChatPageProvider _PageProvider;
  late NavigationServices _navigation;

  @override
  Widget build(BuildContext context){
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<UserRepository>(context);
    _navigation = GetIt.instance.get<NavigationServices>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
          create: (_) => ChatPageProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (BuildContext _context) {
      _PageProvider = _context.watch<ChatPageProvider>();
      return Scaffold(
        body: Container(
          color:Color.fromARGB(255, 238, 233, 233),
          padding: EdgeInsets.symmetric(
            horizontal: _deviceHeight * 0.03,
            vertical: _deviceWidth * 0.02,
          ),
          height: _deviceHeight * 0.9,
          width: _deviceWidth * 0.99,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                'Chats',
              ),
              _chatList()
            ],
          ),
        ),
      );
    });
  }

  Widget _chatList() {
    List<Chat>? _chats = _PageProvider.chats;
    // print(')*('*100);
    

    return SizedBox(
      height: _deviceHeight * 0.6,
      child: (() {
      if (_chats != null) {
        if (_chats.length != 0) {
          print(_chats);
            print('chats');
            print('&^'*100);
          return ListView.builder(
            itemCount: _chats.length,
            itemBuilder: (BuildContext _context, int _index) {
              return _chatTile(
                _chats[_index],
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'No Chats found.',
              style: TextStyle(color: Colors.black),
            ),
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      }
    })());
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recepients = _chat.recepients();
    bool _isActive = _recepients.any((_d) => _d.wasRecentlyActive());
    String _subtitleText = "";
    if (_chat.message.isNotEmpty) {
      // print(MessageType.IMAGE);
      print(_chat.message.first.content);
      print(_chat.recepients().length);
      print('Chat Message');
      print("K"*1000);
      _subtitleText = _chat.message.first.type != MessageType.TEXT
          ? "Media Attachment"
          : _chat.message.first.content;
    }
    // return Text('j');
    return CustomListViewTileWithActivity(
        height: _deviceHeight * 0.10,
        imagePath:_chat.imageeUrl(),
        title: _chat.title(),
        isActive: _isActive,
        isActivity: _chat.activity,
        onTap: () {
          _navigation.navigateToPage(ChatPage(chat: _chat),
          );
        },
        subtitle: _subtitleText
        );
  }
}
