import 'package:chatApp/helper/color_presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget customNavigationBar(int currentPage, Function(int) navigationTapped) {
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: CupertinoTabBar(
        backgroundColor: blackColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: (currentPage == 0) ? lightBlueColor : greyColor,
            ),
            title: Text(
              "Chats",
              style: TextStyle(
                  color: (currentPage == 0) ? lightBlueColor : greyColor,
                  fontSize: 12),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.call,
              color: (currentPage == 1) ? lightBlueColor : greyColor,
            ),
            title: Text(
              "Calls",
              style: TextStyle(
                  color: (currentPage == 1) ? lightBlueColor : greyColor,
                  fontSize: 12),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts,
              color: (currentPage == 2) ? lightBlueColor : greyColor,
            ),
            title: Text(
              "Contacts",
              style: TextStyle(
                  color: (currentPage == 2) ? lightBlueColor : greyColor,
                  fontSize: 12),
            ),
          ),
        ],
        currentIndex: currentPage,
        onTap: navigationTapped,
      ),
    ),
  );
}
