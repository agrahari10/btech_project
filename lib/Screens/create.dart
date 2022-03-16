import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/style.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String imageFilePath = '';
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    adressController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _userRepository = Provider.of<UserRepository>(context);
    void _showErrorSnackBar({required String errorCode}) {
      String errorText;

      if (errorCode == 'invalid-email' || errorCode == 'ERROR_INVALID_EMAIL')
        errorText = 'Invalid email';
      else if (errorCode == 'email-already-in-use' ||
          errorCode == 'account-exists-with-different-credential' ||
          errorCode == 'ERROR_EMAIL_ALREADY_IN_USE')
        errorText = 'Account already exist with email, go to Login page.';
      else if (errorCode == 'operation-not-allowed' ||
          errorCode == 'ERROR_OPERATION_NOT_ALLOWED')
        errorText = 'Server error, please try again later.';
      else
        print('@'*100);
        print(errorCode);
        errorText = 'Error!';

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Expanded(
                child: Text(errorText),
              ),
              Icon(
                Icons.error,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: size.height * 0.16,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.all(size.height*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create',
                        style:
                            KtextStyle.copyWith(fontSize: 30, fontFamily: 'Segoe UI'),
                      ),
                      Text(
                        'Account',
                        style:
                            KtextStyle.copyWith(fontSize: 30, fontFamily: 'Segoe UI'),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: size.height*1.2,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        // color: Color(0xffC91010),
                        style: BorderStyle.solid,
                        color: Color(0xffE5E5E5),

                      ),
                      color: Color(0xffFFF0F3)),
                  child: Padding(
                    padding: EdgeInsets.all(size.height*0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
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
                                borderRadius: BorderRadius.circular(size.width),
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
                                borderRadius: BorderRadius.circular(size.width),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(imageFilePath),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ),
                        SizedBox(
                          // height: 20.0,
                          height: size.height*0.004,

                        ),
                        Text(
                          'Full Name',
                          style: KtextStyle.copyWith(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height*0.004,

                          // height: 30.0,
                        ),
                        Text(
                          'Email',
                          style: KtextStyle.copyWith(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                                prefixIcon: Icon(
                                  Icons.mail_sharp,
                                  color: Colors.black,
                                )
                            ),
                          ),
                        ),
                  SizedBox(
                    height: size.height*0.004,

                  ),
                Text(
                  'Password',
                  style: KtextStyle.copyWith(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
                        SizedBox(
                          height: size.height*0.004,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //         fillColor: Colors.white,
                        //         focusedBorder:OutlineInputBorder(
                        //           borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                        //           borderRadius: BorderRadius.circular(15.0),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        //           borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                        //         ),
                        //         prefixIcon: Icon(
                        //           Icons.lock,
                        //           color: Colors.black,
                        //         )
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: size.height*0.001,
                        ),
                        Text(
                          'Mobile No',
                          style: KtextStyle.copyWith(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                // keyboardType: TextInputType.number,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                )
                            ),
                          ),
                        ),
                        Text(
                          'Address',
                          style: KtextStyle.copyWith(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: adressController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.solidAddressBook,
                                  // Icons.mail_sharp,
                                  color: Colors.black,
                                )
                            ),
                          ),
                        ),
                        Text(
                          'State',
                          style: KtextStyle.copyWith(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: stateController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                                prefixIcon: Icon(
                                  // Icons.mail_sharp,
                                  FontAwesomeIcons.solidAddressBook,
                                  color: Colors.black,
                                )
                            ),
                          ),
                        ),
                        Text(
                          'Country',
                          style: KtextStyle.copyWith(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: countryController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.solidAddressBook,
                                  color: Colors.black,
                                )
                            ),
                          ),
                        ),Center(
                          child: LoginButton(
                            buttonText: "Register",
                            onTap: (imageFilePath.isNotEmpty &&
                                imageFilePath != null &&
                                emailController.value.text.isNotEmpty &&
                                passwordController.value.text.length > 4 &&
                                nameController.value.text.isNotEmpty &&
                                stateController.value.text.isNotEmpty &&
                                countryController.value.text.isNotEmpty)
                                ? () async {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 15),
                                content: Row(
                                  children: [
                                    Expanded(child: Text('Registering...')),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ));
                              await _userRepository
                                  .signup(
                                email: emailController.value.text,
                                password: passwordController.value.text,
                                phoneNumber: phoneController.value.text,
                                name: nameController.value.text,
                                address: adressController.value.text,
                                state: stateController.value.text,
                                country: countryController.value.text,
                                image: File(imageFilePath),
                              )
                                  .then(
                                    (value) => Navigator.of(context).pop(),
                              )
                                  .catchError((error) {
                                _showErrorSnackBar(errorCode: error.code);
                              });
                            }
                                : () {
                              if (imageFilePath.isEmpty)
                                Fluttertoast.showToast(msg: 'Upload photo');
                              else
                                Fluttertoast.showToast(msg: 'Enter all fields');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
