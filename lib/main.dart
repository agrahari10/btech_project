import 'package:btech_project/Screens/HomePage.dart';
import 'package:btech_project/Screens/create.dart';
import 'package:btech_project/Screens/mainsceen.dart';
import 'package:btech_project/repository/Userrepositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Screens/login.dart';
import 'Screens/onboarding.dart';
import 'widgets/style.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserRepository()),
        ],
        child: MyApp(),
      ),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // backgroundColor: Color(0xffB5B6B3),
        scaffoldBackgroundColor: Colors.white,


      ),
      home: Scaffold(body: SafeArea(child: _showScreen(context))),
    );
  }
}
Widget _showScreen(BuildContext context) {
  print(context.watch<UserRepository>().appState);
  switch (context.watch<UserRepository>().appState) {
    case AppState.authenticating:
      print(context.watch<UserRepository>().appState);

      return HomeScreen();
    case AppState.unauthenticated:
      print(context.watch<UserRepository>().appState);

      return Onboarding();
    case AppState.initial:
      print(context.watch<UserRepository>().appState);

      return Onboarding();
    case AppState.authenticated:
      print(context.watch<UserRepository>().appState);

      return MainScreen();
    case AppState.unauthorised:
      print(context.watch<UserRepository>().appState);
      return Container(
        child: Text('dfdfddfdfdfd'),
      );
  }
}



