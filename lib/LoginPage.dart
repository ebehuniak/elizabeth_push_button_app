import 'package:flutter/material.dart';
import 'helpers/Constants.dart';

//creating a stateless widget
class LoginPage extends StatelessWidget {
  // handles all text editing logic
  final _pinCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //this sets up the image displayed as a logo
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      //these are defined in the "Constants" file
      radius: bigRadius,
      child: appLogo,
    );
    //3b
    final pinCode = TextFormField(
      //this variable is private
      controller: _pinCodeController,
      //this sets up the interface like a phone pass-code
      keyboardType: TextInputType.phone,
      // 4 number pin code
      maxLength: 4,
      // 1 line for the pin code
      maxLines: 1,
      //this triggers the keyboard
      autofocus: true,
      decoration: InputDecoration(
          hintText: pinCodeHintText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintStyle: TextStyle(color: Colors.white)),
      style: TextStyle(
        color: Colors.white,
      ),
    );
    //great example of raised button code
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(homePageTag);
        },
        padding: EdgeInsets.all(12),
        color: appGreyColor,
        child: Text(loginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );
    //this is the main UI structural class (in depth in i_am_rich tutorial)
    return Scaffold(
      backgroundColor: mainAppColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: bigRadius),
            pinCode,
            SizedBox(height: buttonHeight),
            loginButton
          ],
        ),
      ),
    );
  }
}
