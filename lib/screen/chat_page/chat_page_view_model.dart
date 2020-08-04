import 'dart:io';

import 'package:chatApp/helper/utils.dart';
import 'package:chatApp/models/message.dart';
import 'package:chatApp/models/user.dart';
import 'package:chatApp/provider/image_upload_provider.dart';
import 'package:chatApp/resources/auth_methods.dart';
import 'package:chatApp/resources/chat_methods.dart';
import 'package:chatApp/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './chat_page.dart';

abstract class ChatPageViewModel extends State<ChatPage> {
  TextEditingController textFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();
  AuthMethods _authMethods = AuthMethods();
  StorageMethods _storageMethods = StorageMethods();
  ChatMethods _chatMethods = ChatMethods();
  FocusNode textFieldFocus = FocusNode();
  ImageUploadProvider imageUploadProvider;
  bool isWriting = false;
  bool showEmojiPicker = false;
  FirebaseUser currentUser;
  User sender;

  setWritingTo(bool newValue) {
    setState(() {
      isWriting = newValue;
    });
  }

  getCurrentUser() {
    _authMethods.getCurrentUser().then((user) {
      setState(() {
        currentUser = user;
        sender = User(
          uid: user.uid,
          name: user.displayName,
          photo: user.photoUrl,
        );
      });
    });
  }

  pickImage({@required ImageSource source}) async {
    File selectedFile = await Utils.pickImage(source: source);
    _storageMethods.uploadImage(
      image: selectedFile,
      receiverId: widget.receiver.uid,
      senderId: currentUser.uid,
      imageUploadProvider: imageUploadProvider,
    );
  }

  showKeyboard() => textFieldFocus.requestFocus();

  hiddenKeyboard() => textFieldFocus.unfocus();

  hiddenEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  sendMessage() {
    String text = textFieldController.text;

    Message _message = Message(
      receiverId: widget.receiver.uid,
      senderId: sender.uid,
      message: text,
      timestamp: Timestamp.now(),
      type: text,
    );

    _chatMethods.addMessageToDb(_message, sender, widget.receiver);
    setState(() {
      isWriting = false;
      textFieldController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
}
