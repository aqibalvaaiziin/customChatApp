
import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/screen/chat_list_page/widgets/chat_list_tile.dart';
import 'package:flutter/material.dart';

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  const ModalTile({Key key, this.title, this.subtitle, this.icon, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTileItem(
          onTap: onTap,
          mini: false,
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: receiverColor,
            ),
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              color: greyColor,
              size: 38,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: greyColor,
            ),
          )),
    );
  }
}
