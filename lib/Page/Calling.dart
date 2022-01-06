import 'package:btech_project/widgets/style.dart';
import 'package:flutter/material.dart';

class Call extends StatelessWidget {
  const Call({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Calling Comming soon',style: KRtextStyle,),
        ),
      ),
    );
  }
}
