import 'package:chatApp/db/log_repository.dart';
import 'package:chatApp/helper/const_config.dart';
import 'package:chatApp/models/log.dart';
import 'package:chatApp/resources/call_methods.dart';
import 'package:flutter/material.dart';
import './pickup_page.dart';

abstract class PickupPageViewModel extends State<PickupPage> {
  CallMethods callMethods = CallMethods();
  bool isCallMissed = true;
  bool isCalledMissed = true;

  addToLocalStorage({@required String callStatus}) {
    Log log = Log(
      callerName: widget.call.callerName,
      callerPic: widget.call.callerPic,
      receiverName: widget.call.receiverName,
      receiverPic: widget.call.receiverPic,
      timestamp: DateTime.now().toString(),
      callStatus: callStatus,
    );
    LogRepository.addLogs(log);
  }

  @override
  void dispose() {
    super.dispose();
    if (isCallMissed) {
      addToLocalStorage(callStatus: CALL_STATUS_MISSED);
    }
  }
}
