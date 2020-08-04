import 'package:chatApp/helper/call_utilities.dart';
import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/helper/const_config.dart';
import 'package:chatApp/helper/permission.dart';
import 'package:chatApp/models/message.dart';
import 'package:chatApp/models/user.dart';
import 'package:chatApp/widgets/chaced_data_image.dart';
import 'package:chatApp/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'custom_navigate.dart';

Widget messageList(BuildContext context, FirebaseUser currentUser,
    User receiverUser, ScrollController scrollController) {
  return StreamBuilder(
    stream: Firestore.instance
        .collection(MESSAGE_COLLECTION)
        .document(currentUser.uid)
        .collection(receiverUser.uid)
        .orderBy(TIMESTAMP_FIELD, descending: true)
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.data == null) {
        return Center();
      }

      SchedulerBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });

      return ListView.builder(
        controller: scrollController,
        reverse: true,
        padding: EdgeInsets.all(10),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, i) {
          return chatMessageItem(
            context,
            snapshot.data.documents[i],
            currentUser,
            receiverUser,
          );
        },
      );
    },
  );
}

Widget chatMessageItem(
  BuildContext context,
  DocumentSnapshot snapshot,
  FirebaseUser currentUser,
  User receiverUser,
) {
  Message _message = Message.fromMap(snapshot.data);
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Container(
      alignment: _message.senderId == currentUser.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: _message.senderId == currentUser.uid
          ? senderLayout(context, _message)
          : receiverLayout(context, _message, receiverUser),
    ),
  );
}

Widget senderLayout(BuildContext context, Message message) {
  Radius messageRadius = Radius.circular(10);
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
        decoration: BoxDecoration(
          color: senderColor,
          borderRadius: BorderRadius.only(
            topLeft: messageRadius,
            topRight: messageRadius,
            bottomLeft: messageRadius,
          ),
        ),
        child: getMessage(message),
      ),
    ],
  );
}

Widget receiverLayout(
    BuildContext context, Message message, User receiverUser) {
  Radius messageRadius = Radius.circular(10);

  return Row(
    children: <Widget>[
      Container(
        constraints: BoxConstraints(maxWidth: 35, maxHeight: 35),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(receiverUser.photo),
        ),
      ),
      SizedBox(width: 5),
      Container(
        padding: EdgeInsets.all(10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
        decoration: BoxDecoration(
          color: receiverColor,
          borderRadius: BorderRadius.only(
            bottomRight: messageRadius,
            topRight: messageRadius,
            bottomLeft: messageRadius,
          ),
        ),
        child: getMessage(message),
      ),
    ],
  );
}

Widget getMessage(Message message) {
  return message.type != MESSAGE_TYPE_IMAGE
      ? Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        )
      : message.photoUrl != null
          ? ChachedImageData(
              message.photoUrl,
              width: 150,
              height: 150,
              radius: 10,
            )
          : Text("url was null");
}

CustomAppBar customAppBar(BuildContext context, User sender, User receiver) {
  return CustomAppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => backScreen(context),
    ),
    centerTitle: false,
    title: Text(receiver.name),
    actions: <Widget>[
      IconButton(
          icon: Icon(Icons.video_call),
          onPressed: () async =>
              await Permissions.cameraAndMicrophonePermissionsGranted()
                  ? CallUtils.dial(
                      from: sender,
                      to: receiver,
                      context: context,
                    )
                  : {}),
      IconButton(
        icon: Icon(Icons.phone),
        onPressed: () {},
      ),
    ],
  );
}
