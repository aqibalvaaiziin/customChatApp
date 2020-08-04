
import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/screen/call_list_page/call_list_page.dart';
import 'package:chatApp/screen/chat_list_page/chat_list_page.dart';
import 'package:chatApp/screen/contact_list_page/contact_list_page.dart';
import 'package:chatApp/screen/pickup_page/widgets/pickup_screen.dart';
import 'package:chatApp/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import './home_page_view_model.dart';

class HomePageView extends HomePageViewModel {
  @override
  Widget build(BuildContext context) {
    return PickupScreen(
      scaffold: Scaffold(
        backgroundColor: blackColor,
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChangedAction,
          children: <Widget>[
            Center(
              child: ChatListPage(),
            ),
            Center(
              child: CallListPage(),
            ),
            Center(
              child: ContactListPage(),
            ),
          ],
        ),
        bottomNavigationBar: customNavigationBar(currentPage, navigationTapped),
      ),
    );
  }
}
