
import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/models/user.dart';
import 'package:chatApp/screen/chat_list_page/widgets/chat_list_tile.dart';
import 'package:chatApp/screen/chat_page/chat_page.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import './search_page_view_model.dart';

class SearchPageView extends SearchPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: searchAppBar(context),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
    );
  }

  buildSuggestions(String query) {
    final List<User> suggestionList = query.isEmpty
        ? []
        : userList.where((User user) {
            String _getUsername = user.username.toLowerCase();
            String _query = query.toLowerCase();
            String _getName = user.name.toLowerCase();
            String _getEmail = user.email.toLowerCase();
            bool matchUsername = _getUsername.contains(_query);
            bool matchEmail = _getEmail.contains(_query);
            bool matchName = _getName.contains(_query);

            return (matchUsername || matchName || matchEmail);
            //
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, i) {
        User searchUser = User(
          uid: suggestionList[i].uid,
          photo: suggestionList[i].photo,
          name: suggestionList[i].name,
          username: suggestionList[i].username,
        );
        //
        return Container(
          margin: EdgeInsets.symmetric(vertical: 9),
          child: CustomTileItem(
              mini: false,
              onTap: () => nextScreen(
                    context,
                    ChatPage(
                      receiver: searchUser,
                    ),
                  ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  searchUser.photo,
                ),
                backgroundColor: Colors.white,
              ),
              title: Text(
                searchUser.username,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                searchUser.name,
                style: TextStyle(
                  color: greyColor,
                ),
              )),
        );
      },
    );
  }

  searchAppBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GradientAppBar(
      gradient: fabGradient,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => backScreen(context),
      ),
      elevation: 0,
      flexibleSpace: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: width * 0.14, top: width * 0.07),
              width: width * 0.7,
              child: TextField(
                controller: searchController,
                autofocus: true,
                onChanged: (value) => onInputChanged(value),
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Find someone...",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, width * 0.07, 0, 0),
              child: IconButton(
                icon: Icon(
                  FontAwesome.times,
                  color: Colors.white,
                ),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => searchController.clear(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
