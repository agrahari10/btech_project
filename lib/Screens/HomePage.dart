import 'package:btech_project/repository/Userrepositories.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _userRepository = Provider.of<UserRepository>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //         },
        //       icon: Icon(Icons.arrow_back),
        //       color: Colors.black,
        //     ),
        //     IconButton(
        //       onPressed: () async{
        //         await _userRepository.logout();
        //       },
        //       icon: Icon(Icons.logout),
        //       color: Colors.black,
        //     ),
        //   ],
        // ),


      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context ,int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.35,
              child: Column(
                children: [
                  CarouselSlider(
                    items: [
                      //1st Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('images/one.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //2nd Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('images/two.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //3rd Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('images/three.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //4th Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('images/four.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //5th Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('images/four.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                      height: 200,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.9,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.height*0.03),
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
