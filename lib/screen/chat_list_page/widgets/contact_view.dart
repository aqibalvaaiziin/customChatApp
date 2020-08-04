
import 'package:chatApp/models/contact.dart';
import 'package:chatApp/models/user.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:chatApp/resources/auth_methods.dart';
import 'package:chatApp/resources/chat_methods.dart';
import 'package:chatApp/screen/chat_list_page/widgets/chat_list_tile.dart';
import 'package:chatApp/screen/chat_list_page/widgets/last_message.dart';
import 'package:chatApp/screen/chat_list_page/widgets/online_dot_indicator.dart';
import 'package:chatApp/screen/chat_page/chat_page.dart';
import 'package:chatApp/widgets/chaced_data_image.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTileItem(
      mini: false,
      onTap: () => nextScreen(
          context,
          ChatPage(
            receiver: contact,
          )),
      title: Text(
        (contact != null ? contact.name : null) != null ? contact.name : "..",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Arial",
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
        child: Stack(
          children: <Widget>[
            ChachedImageData(
              contact.photo,
              radius: 40,
              isRound: true,
            ),
            Positioned(
              bottom: 0,
              right: -5,
              child: OnlineDotIndicator(
                uid: contact.uid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
