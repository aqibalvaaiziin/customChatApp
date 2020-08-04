import 'package:chatApp/helper/color_presets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import './login_page_view_model.dart';

class LoginPageView extends LoginPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: loginButton(),
          ),
          isLogginPressed
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: senderColor,
      child: FlatButton(
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontFamily: "eb",
            fontSize: 27,
          ),
        ),
        onPressed: () {
          onGoogleSignIn();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
