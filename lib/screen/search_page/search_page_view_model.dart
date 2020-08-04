import 'dart:async';
import 'package:chatApp/models/user.dart';
import 'package:chatApp/resources/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './search_page.dart';

abstract class SearchPageViewModel extends State<SearchPage> {
  Timer _debounce;
  List<User> userList;
  AuthMethods _authMethods = AuthMethods();
  String query = "";
  TextEditingController searchController = TextEditingController();
  bool isChanged = false;

  onInputChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        query = value;
      });
    });
  }

  void getCurrentuser() {
    _authMethods.getCurrentUser().then((FirebaseUser user) {
      _authMethods.getAllUser(user).then((List<User> list) {
        print(list.length);
        setState(() {
          userList = list;
          print(userList[0].name);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }
}
