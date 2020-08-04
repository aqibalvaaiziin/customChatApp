
import 'package:chatApp/helper/preferences_data.dart';
import 'package:chatApp/resources/auth_methods.dart';
import 'package:chatApp/screen/home_page/home_page.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './login_page.dart';

abstract class LoginPageViewModel extends State<LoginPage> {
  PreferencesData _preferencesData = PreferencesData();
  AuthMethods _authMethods = AuthMethods();
  bool isLogginPressed = false;

  void onGoogleSignIn() async {
    FirebaseUser user = await _authMethods.signIn();
    authenticationUser(user);
    setState(() {
      isLogginPressed = true;
    });
  }

  void authenticationUser(FirebaseUser user) {
    _authMethods.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLogginPressed = false;
      });
      if (isNewUser) {
        _authMethods.addDatatoDb(user).then((value) {
          _preferencesData.setUserLogin(user);
          nextScreenReplacement(context, HomePage(email: user.email));
        });
      } else {
        _preferencesData.setUserLogin(user);
        nextScreenReplacement(context, HomePage(email: user.email));
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
