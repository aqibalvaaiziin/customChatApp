import 'dart:math';

import 'package:chatApp/models/call.dart';
import 'package:chatApp/models/user.dart';
import 'package:chatApp/resources/call_methods.dart';
import 'package:chatApp/screen/pickup_page/widgets/call_screen.dart';
import 'package:chatApp/widgets/custom_navigate.dart';



class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
    print("from : ${from.photo}");
    print("to : ${to.photo}");
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.photo,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.photo,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      nextScreen(
          context,
          CallScreen(
            call: call,
          ));
    }
  }
}
