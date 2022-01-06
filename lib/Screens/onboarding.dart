import 'package:btech_project/Screens/create.dart';
import 'package:btech_project/widgets/style.dart';
import 'package:flutter/material.dart';

import 'login.dart';


class Onboarding extends StatelessWidget {
const Onboarding({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Column(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/onb.gif'
                  )
                )
              ),
              height:size.height*0.60,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text('Welcome to the locally',style: KtextStyle.copyWith(fontSize: 35),),
              ),
            ),
          ),
          Container(
            height: size.height*0.30,
            width: size.width*0.95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  topRight: Radius.circular(45.0),
                  bottomLeft: Radius.circular(45.0),
                  bottomRight: Radius.circular(45.0),

                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius:3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                  width: 1,
                  color: Color(0xffE5E5E5),
                  style: BorderStyle.solid,
                ),
                color: Color(0xffFFF0F3)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  children: [
                    Text('By continuing you agree to our',style: KtextStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Terms',style: KtextStyle.copyWith(color: Color(0xffC91010)),),
                        Text(' &',style: KtextStyle,),
                        Text(' Conditions',style: KtextStyle.copyWith(color: Color(0xffC91010)),),


                      ],

                    ),
                    Text('and',style: KtextStyle,),
                    Text('Privacy Policy',style: KtextStyle.copyWith(color: Color(0xffC91010)),),
                    SizedBox(
                      height: size.height*0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: Text("Sign In",style: KtextStyle.copyWith(color: Colors.white),),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },

                              // Navigator.of(context).pushNamed(MaterialPageRoute(builder: (context)=>CreateAccount));
                              // print("it's pressed"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff37474F),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: Text("Sign Up",style: KtextStyle.copyWith(color: Colors.white),),
                          onPressed: () {
                            print("signUP pressed");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff37474F),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),

                      ],
                    )



                  ],
                ),
              ),
            ),
          )
        ],

      ),
    ),
  );
}
}