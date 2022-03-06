// import 'dart:async';
import 'dart:io';

import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/CustomTextField.dart';
import 'package:btech_project/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String imageFilePath = '';
  String? _name;
  String? _email;
  // String? _password;
  String? _phoneNumber;
  String? _country;
  String? _state;
  String? _address;

class _ProfilePageState extends State<ProfilePage> {
  final _updateFormKey =  GlobalKey<FormState>();
  
  late double _deviceHeight;
  late double _deviceWidth;
  UserRepository? _userRepository;
  

  @override
  Widget build(BuildContext context) {
     _userRepository = Provider.of<UserRepository>(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceHeight * 0.03,
            vertical: _deviceWidth * 0.03,
          ),
          child: SingleChildScrollView(
            
            child: Container(
              // color: Colors.red,
              height: _deviceHeight * 0.95,
              width: _deviceWidth * 0.80,
              child: Form(
                key: _updateFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _profileUpdate(),
          
                    CustomTextField(
                      obscureText: false,
                      onSaved: (_value) {
                        setState(() {
                          _name = _value;
                        });
                      },
                      hintText: "Name",
                      regEx: r'.{2,}',
                    ),
                    // CustomTextField(
                    //   obscureText: false,
                    //   onSaved: (_value) {
                    //     setState(() {
                    //       _email = _value;
                    //     });
                    //   },
                    //   hintText: "Email",
                    //   regEx: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          
                    //   // regEx: r'.{8,}',
                    // ),
                    // CustomTextField(
                    //   obscureText: true,
                    //   onSaved: (_value) {
                    //     setState(() {
                    //       _password = _value;
                    //     });
                    //   },
                    //   hintText: "Password",
                    //   regEx: r'.{8,}',
                    // ),
                    CustomTextField(
                      obscureText: false,
                      onSaved: (_value) {
                        setState(() {
                          _phoneNumber = _value;
                        });
                      },
                      hintText: "Phone Number",
                      // regEx: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          
                      // regEx: r'.{2,}',
                      regEx: r'(^(?:[+0]9)?[0-9]{10,12}$)',
                    ),
                    CustomTextField(
                      obscureText: false,
                      onSaved: (_value) {
                        setState(() {
                          _country = _value;
                        });
                      },
                      hintText: "Country",
                      regEx: r'.{2,}',
                    ),
                    CustomTextField(
                      obscureText: false,
                      onSaved: (_value) {
                        setState(() {
                          _state = _value;
                        });
                      },
                      hintText: "State",
                      regEx: r'.{2,}',
                    ),
                    CustomTextField(
                      obscureText: false,
                      onSaved: (_value) {
                        setState(() {
                          _address = _value;
                        });
                      },
                      hintText: "addresh",
                      // regEx: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          
                      regEx: r'.{2,}',
                    ),
                    _registerButton()
                  ],
                ),
              ),
            ),
          ),
          // child: Column(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     // SizedBox(
          //     //   height: _deviceHeight * 0.01,
          //     // ),
          //     // _profileUpdate(),
          //     //
          //     // SizedBox(
          //     //   height: _deviceHeight * 0.05,
          //     // ),
          //
          //     // _registerForm(),
          //
          //
          //   ],
          // ),
        ),
      ),
    );
  }
  Widget _profileUpdate(){
    return GestureDetector(
      onTap: () async {
        var image = await ImagePicker()
            .getImage(
            source: ImageSource.gallery,
            maxHeight: 600,
            maxWidth: 600)
            .then((value) {
          if (mounted)
            setState(() {
              print(value?.path);
              print('&&&&&&&&&&&&&&\n%%%%%%%%%%%%');
              imageFilePath = value != null ? value.path : '';
              print(imageFilePath);
            });
        });
      },
      child: imageFilePath.isEmpty
          ? Container(
        height: 100,
        width: 100,
        child: Icon(Icons.add_a_photo),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_deviceWidth),
          color: Color(0xffFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
      )
          : Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_deviceWidth),
          image: DecorationImage(
            image: FileImage(
              File(imageFilePath),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _registerForm() {
  //   return
  // }
  Widget _registerButton() {
    return RoundedButton(
        width: _deviceWidth * 0.65,
        height: _deviceHeight * 0.065,
        name: 'Update',
        onPressed: ()async {
          print(imageFilePath);
          print("7"*100);
          print(_updateFormKey.currentState!.validate());
          if(_updateFormKey.currentState!.validate() && imageFilePath.isNotEmpty){
            _updateFormKey.currentState!.save();
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(minutes:10),
              content: Row(
                children: [
                  Expanded(child: Text('Updating...')),
                  CircularProgressIndicator(),
                ],
              ),
            ),);
            await _userRepository!.updateUserProfile(name: _name!, phoneNumber: _phoneNumber!, address: _address!, state: _state!, country: _country!, image: File(imageFilePath),);
           ScaffoldMessenger.of(context).hideCurrentSnackBar();
           Navigator.pop(context);
            // await  _userRepository;
            // String? _uid = await _auth.registerUserUsingEmailAndPassword(_email!, _password!);
            // // CircularProgressIndicator();
            // String? _imageUrl = await _cloudStorageServices.saveUserImageToStorage(_uid!, _profileImage!);
            // await _db.createUser(_uid, _email!, _name!, _imageUrl!);
            // CircularProgressIndicator();
            // await _auth.logout();
            // await _auth.loginUsingEmailAndPassword(_email!, _password!);
          }else{
              print('errror');
          }}
        );}

}