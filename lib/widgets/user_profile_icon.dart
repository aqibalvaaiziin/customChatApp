
import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/helper/utils.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCircle extends StatelessWidget {
  final String text;
  final bool inChat;
  const UserCircle({
    Key key,
    this.text,
    this.inChat = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      height: inChat ? 38 : 40,
      width: inChat ? 38 : 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: inChat ? senderColor : separatorColor,
      ),
      child: Stack(
        children: <Widget>[
          // initialName
          Align(
            alignment: Alignment.center,
            child: Text(
              Utils.getInitals(userProvider.getUser.name),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: lightBlueColor,
                fontSize: 13,
              ),
            ),
          ),
          //boxInital
          inChat
              ? SizedBox()
              : Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: onlineDotColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: blackColor,
                        width: 2,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
