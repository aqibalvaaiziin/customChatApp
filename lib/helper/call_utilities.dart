import 'dart:math';

import 'package:chatApp/db/log_repository.dart';
import 'package:chatApp/helper/const_config.dart';
import 'package:chatApp/models/call.dart';
import 'package:chatApp/models/log.dart';
import 'package:chatApp/models/user.dart';
import 'package:chatApp/resources/call_methods.dart';
import 'package:chatApp/screen/pickup_page/widgets/call_screen.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.photo,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.photo,
      channelId: Random().nextInt(1000).toString(),
    );

    Log log = Log(
      callerName: from.name,
      callerPic: from.photo,
      callStatus: CALL_STATUS_DIALLED,
      receiverName: to.name,
      receiverPic: to.photo,
      timestamp: DateTime.now().toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      // enter log
      LogRepository.addLogs(log);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );
    }
  }
}
