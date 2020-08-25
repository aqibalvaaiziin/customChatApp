import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/screen/call_list_page/widget/log_list_container.dart';
import 'package:chatApp/screen/search_page/search_page.dart';
import 'package:chatApp/widgets/custom_log_appbar.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:chatApp/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import './call_list_page_view_model.dart';

class CallListPageView extends CallListPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingColumnButton(),
        backgroundColor: blackColor,
        appBar: CustomLogAppBar(
          title: "Log Calls",
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
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: ListLogContainer(),
        ));
  }
}
