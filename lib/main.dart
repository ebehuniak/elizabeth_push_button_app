import 'package:flutter/material.dart';
//the files that are called
import 'helpers/Constants.dart';
import 'LoginPage.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
  };
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: new ThemeData(
        primaryColor: mainAppColor,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
