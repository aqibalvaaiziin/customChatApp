import 'dart:io';
import 'dart:math';

import 'package:chatApp/enum/user_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static final picker = ImagePicker();

  static String getUsername(String email) {
    return "live:${email.split('@')[0]}";
  }

  static String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formater = DateFormat('dd//MM//yy');
    return formater.format(dateTime);
  }

  static String getInitals(String name) {
    List<String> nameSplit = name.split(" ");
    String firstName = nameSplit[0][0];
    String lastName = nameSplit[1][0];
    return "$firstName$lastName".toUpperCase();
  }

  static Future<File> pickImage({@required ImageSource source}) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);
    return compressImage(image);
  }

  static Future<File> compressImage(File imageToCompress) async {
    final tempDir = await getTemporaryDirectory();

    final path = tempDir.path;

    int random = Random().nextInt(10000);

    var image = imageToCompress.readAsBytesSync();

    return new File("$path/image_$random.jpg")..writeAsBytesSync(image);
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;
      case UserState.Online:
        return 1;
      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
    switch (number) {
      case 0:
        return UserState.Offline;
      case 1:
        return UserState.Online;
      default:
        return UserState.Waiting;
    }
  }
}
