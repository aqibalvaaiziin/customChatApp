import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/screen/chat_list_page/widgets/container_list.dart';
import 'package:chatApp/screen/chat_list_page/widgets/user_detail_container.dart';
import 'package:chatApp/screen/pickup_page/widgets/pickup_screen.dart';
import 'package:chatApp/screen/search_page/search_page.dart';
import 'package:chatApp/widgets/custom_app_bar.dart';
import 'package:chatApp/widgets/custom_log_appbar.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:chatApp/widgets/custom_new_chat_button.dart';
import 'package:chatApp/widgets/user_profile_icon.dart';
import 'package:flutter/material.dart';
import './chat_list_page_view_model.dart';

class ChatListPageView extends ChatListPageViewModel {
  @override
  Widget build(BuildContext context) {
    return PickupScreen(
      scaffold: Scaffold(
        backgroundColor: blackColor,
        floatingActionButton: CustomButtonForNewChat(),
        appBar: CustomLogAppBar(
          title: UserCircle(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () => nextScreen(context, SearchPage()),
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: ContainerChat(),
      ),
    );
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications_active,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: GestureDetector(
        child: UserCircle(),
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) => UserDetailContainer(),
            isScrollControlled: true),
      ),
      centerTitle: true,
    );
  }
}
