import 'package:chatApp/models/user.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:chatApp/widgets/chaced_data_image.dart';
import 'package:chatApp/widgets/chat_widget.dart';
import 'package:chatApp/widgets/custom_app_bar.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
      child: Row(
        children: <Widget>[
          ChachedImageData(
            user.photo,
            isRound: true,
            radius: 50,
          ),
          SizedBox(width: 15),
          Text(
            user.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
