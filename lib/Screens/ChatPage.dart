import 'package:btech_project/Models/Chat.dart';
import 'package:btech_project/Models/Chat_message.dart';
import 'package:btech_project/Provider/Chat_page_provider.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/CustomList_tile.dart';
import 'package:btech_project/widgets/CustomTextField.dart';
import 'package:btech_project/widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({required this.chat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;

   UserRepository? _auth;
   ChatPageProvider? _pageProvider;

   GlobalKey<FormState>? _messageFormState;
   ScrollController? _messageListViewController;
  @override
  void initState() {
    _messageFormState = GlobalKey<FormState>();
    _messageListViewController = ScrollController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<UserRepository>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
            create: (_) => ChatPageProvider(
                this.widget.chat.uid, _auth!, _messageListViewController!)),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<ChatPageProvider>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.03,
                vertical: _deviceWidth * 0.02,
              ),
              height: _deviceHeight,
              width: _deviceWidth * 0.97,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TopBar(
                    this.widget.chat.title(),
                    fontSize: 10,
                    primaryAction: IconButton(
                      icon: Icon(Icons.delete),
                      color: Color.fromRGBO(0, 82, 218, 1.0),
                      onPressed: () {
                        _pageProvider!.deleteChat();
                      },
                    ),
                    secondaryAction: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Color.fromRGBO(0, 82, 218, 1.0),
                      onPressed: () {
                        _pageProvider!.goBack();
                      },
                    ),
                  ),
                  _messagesListView(),
                  _sendMessageForm(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _messagesListView() {
    if (_pageProvider!.messages != null) {
      if (_pageProvider!.messages!.length != 0) {
        return Container(
          height: _deviceHeight*0.70,
          // width: _deviceWidth * ,
          child: Container(
            height: 400,
            child: ListView.builder(
              controller: _messageListViewController,
              itemCount: _pageProvider!.messages!.length,
              itemBuilder: (BuildContext _context, int _index) {
                ChatMessage _message = _pageProvider!.messages![_index];
                bool _isOwnMessage = _message.senderID == _auth!.user!.uuid;
                return CustomChatListViewTile(
                  deviceHeight: _deviceHeight * 1.2,
                  width: _deviceWidth,
                  message: _message,
                  isOwnMessage: _isOwnMessage,
                  sender: this
                      .widget
                      .chat
                      .members
                      .where((_m) => _m.uuid == _message.senderID)
                      .first,
                );
              },
            ),
          ),
        );
      } else {
        return Align(
          alignment: Alignment.center,
          child: Text(
            'Say Hi!..',
            style: TextStyle(color: Colors.red),
          ),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }
  }

  Widget _sendMessageForm() {
    return Container(
      height: _deviceHeight * 0.06,
      // width: _deviceWidth * 0.0,
      decoration: BoxDecoration(
        // color: Color.fromRGBO(30, 29, 37, 1.0),
        borderRadius: BorderRadius.circular(100),
      ),
      margin: EdgeInsets.symmetric(
          vertical: _deviceHeight * 0.04,
           horizontal: _deviceWidth * 0.04),
      child: Form(
        key: _messageFormState,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _imageMessageButton(),
             _messageTextField(),
            //  SizedBox(width: 10.0,),
            _sendMessageButton(),

          ],
        ),
      ),
    );
  }

  Widget _messageTextField() {
    return SizedBox(
        width: _deviceWidth * 0.65,
        child: CustomTextField(
          hintText: "Type a message",
          obscureText: false,
          onSaved: (_value) {
            _pageProvider!.message = _value;
          },
          regEx: r"^(?!\s*$).+",
        ));
  }

  Widget _sendMessageButton(){
    double _size = _deviceHeight * 0.04;
    return Container(
      height: _size,
      width: _size,
      child: IconButton(onPressed: (){
        if(_messageFormState!.currentState!.validate()){
          _messageFormState!.currentState!.save();
          _pageProvider!.sendTextMessage();
          _messageFormState!.currentState!.reset();  
        }
      }, icon: Icon(Icons.send)),
    );
  }
  Widget _imageMessageButton(){
    double _size = _deviceHeight * 0.04;
    return Container(
      height: _size,
      width: _size,
      child: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 82, 218, 1.0),
        onPressed: (){
          _pageProvider!.sendImageMessage();
        },
        child: Icon(Icons.camera_enhance,
      ),
    ),);
  }
}
