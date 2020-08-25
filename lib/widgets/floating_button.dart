import 'package:chatApp/helper/color_presets.dart';
import 'package:flutter/material.dart';

class FloatingColumnButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: fabGradient,
          ),
          child: Icon(
            Icons.dialpad,
            color: Colors.white,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: blackColor,
            border: Border.all(
              width: 2,
              color: gradientColorEnd,
            ),
          ),
          child: Icon(
            Icons.add_call,
            color: Colors.white,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        )
      ],
    );
  }
}
