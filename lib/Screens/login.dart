import 'package:btech_project/repository/Userrepositories.dart';
import 'package:btech_project/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../widgets/style.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final _userRepository = Provider.of<UserRepository>(context);
    Size size = MediaQuery.of(context).size;
    void _showErrorSnackBar({required String errorCode}) {
      String errorText;
      if (errorCode == 'wrong-password' ||
          errorCode == 'ERROR_WRONG_PASSWORD') {
        errorText = 'Wrong password, try again';
      } else if (errorCode == 'user-not-found' ||
          errorCode == 'ERROR_USER_NOT_FOUND') {
        errorText = 'Account not found, go to Register page';
      } else if (errorCode == 'user-disabled' ||
          errorCode == 'ERROR_USER_DISABLED') {
        errorText = 'Account disabled';
      } else if (errorCode == 'operation-not-allowed' ||
          errorCode == 'too-many-requests' ||
          errorCode == 'ERROR_TOO_MANY_REQUESTS') {
        errorText = 'Too many invalid requests, try again in 5 minutes';
      } else if (errorCode == 'invalid-email' ||
          errorCode == 'ERROR_INVALID_EMAIL') {
        errorText = 'Invalid email';
      } else if (errorCode == 'operation-not-allowed' ||
          errorCode == 'ERROR_OPERATION_NOT_ALLOWED') {
        errorText = 'Server error, please try again later.';
      } else if (errorCode == 'network-request-failed') {
        errorText = 'Check your interner connection';
      } else {
        errorText = 'Login failed, try again!';
      }

      Fluttertoast.showToast(msg: errorText);
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
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
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
                  height: size.height*0.80,
                  width: size.width*0.98,
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
                        color: Color(0xffE5E5E5),
                        style: BorderStyle.solid,
                      ),
                      color: Color(0xffFFF0F3)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 120.0,
                          ),

                          Text(
                            'Email',
                            style: KtextStyle.copyWith(fontSize: 18),
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(13.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                                prefixIcon: Icon(
                                  Icons.mail_sharp,
                                  color: Colors.black,
                                )
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Password',
                            style: KtextStyle.copyWith(fontSize: 18),
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xfffE11E1E), width: 3.0),
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(13.0)),
                                  borderSide: BorderSide(width: 2,color: Color(0xff37474F)),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                )
                            ),

                          ),

                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: LoginButton(
                              buttonText: "Log in",
                              onTap: () async {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Row(
                                      children: [
                                        Expanded(child: Text('Loging in...')),
                                        CircularProgressIndicator(),
                                      ],
                                    )));

                                await _userRepository
                                    .login(emailController.value.text,
                                    passwordController.value.text)
                                    .catchError((error) {
                                  print(error.code.toString() + ' on loginPage');
                                  _showErrorSnackBar(errorCode: error.code);
                                }).then((value) {
                                  Navigator.of(context).pop();
                                });

                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                            ),
                          ),



                        ],
                      ),
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
