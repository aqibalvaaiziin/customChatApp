import 'package:chatApp/models/user.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:chatApp/resources/auth_methods.dart';
import 'package:chatApp/screen/login_page/login_page.dart';
import 'package:chatApp/widgets/chaced_data_image.dart';
import 'package:chatApp/widgets/custom_app_bar.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();
      if (isLoggedOut) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          CustomAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => backScreen(context),
            ),
            centerTitle: true,
            // title: ShimmeringLogo(),
            actions: <Widget>[
              FlatButton(
                onPressed: () => signOut(),
                child: Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
          UserDetailsBody(),
        ],
      ),
    );
  }
}

class UserDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              ChachedImageData(
                user.photo,
                isRound: true,
                radius: 50,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
