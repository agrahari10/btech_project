import 'package:btech_project/widgets/style.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Chat Comming soon',style: KRtextStyle,),
        ),
      ),
    );
  }
}
