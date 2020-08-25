import 'package:chatApp/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CustomLogAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final List<Widget> actions;

  const CustomLogAppBar({Key key, this.title, this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {},
      ),
      centerTitle: true,
      title: title is String
          ? Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
