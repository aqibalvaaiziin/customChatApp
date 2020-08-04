import 'package:chatApp/resources/auth_methods.dart';
import 'package:chatApp/screen/login_page/login_page.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import './chat_list_page.dart';

abstract class ChatListPageViewModel extends State<ChatListPage> {
  AuthMethods _authMethods = AuthMethods();

  void signOut() {
    _authMethods.signOut();
    nextScreenReplacement(context, LoginPage());
  }

  @override
  void initState() {
    super.initState();
  }
}
