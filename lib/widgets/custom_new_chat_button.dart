import 'package:chatApp/helper/color_presets.dart';
import 'package:flutter/material.dart';

class CustomButtonForNewChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: fabGradient,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
