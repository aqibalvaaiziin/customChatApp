import 'package:chatApp/models/contact.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:chatApp/resources/chat_methods.dart';
import 'package:chatApp/screen/chat_list_page/widgets/contact_view.dart';
import 'package:chatApp/screen/chat_list_page/widgets/quiet_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerChat extends StatefulWidget {
  final String currentUserId;

  const ContainerChat({Key key, this.currentUserId}) : super(key: key);

  @override
  _ContainerChatState createState() => _ContainerChatState();
}

class _ContainerChatState extends State<ContainerChat> {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox();
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);
                  return ContactView(contact);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
