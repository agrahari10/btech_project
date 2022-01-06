import 'package:flutter/material.dart';


class LoginButton extends StatelessWidget {
  LoginButton({this.buttonText="",required this.onTap});
  final String buttonText;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 217,
        height: 51,
        decoration: BoxDecoration(
          color: Color(0xff37474F),
          //border: Border.all(color: kButtonShadowColor),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(1,1),
              spreadRadius:0,
              blurRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(buttonText,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
