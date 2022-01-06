import 'package:btech_project/Screens/HomePage.dart';
import 'package:btech_project/Screens/mainsceen.dart';
import 'package:flutter/material.dart';

import '../widgets/style.dart';

class Sucessfull extends StatelessWidget {
  // const Sucessfull({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(size.height*0.1),
          child: Column(
            children: [
              Container(
                height: size.height*0.5,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'images/successfull.gif',
                        ),
                      fit: BoxFit.fitHeight
                    )
                ),
                ),
              SizedBox(
                height: 25.0,
              ),
              Text('Login Successful !!',style: KRtextStyle,),
              SizedBox(
                height: 25.0,
              ),
              Text('You logged in successfully',style: KtextStyle.copyWith(fontSize: 18.0,fontWeight: FontWeight.w400),),
              SizedBox(
                height: 25.0,
              ),

              Center(
                child: ElevatedButton(
                  child: Text("Go to HomePage",style: KtextStyle.copyWith(color: Colors.white),),
                  onPressed: (){
                    print("%%*10");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff37474F),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
