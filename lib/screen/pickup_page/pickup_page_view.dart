import 'package:chatApp/helper/const_config.dart';
import 'package:chatApp/helper/permission.dart';
import 'package:chatApp/screen/pickup_page/widgets/call_screen.dart';
import 'package:chatApp/widgets/chaced_data_image.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import './pickup_page_view_model.dart';

class PickupPageView extends PickupPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming.....",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            ChachedImageData(
              widget.call.callerPic,
              radius: 180,
              isRound: true,
            ),
            SizedBox(height: 15),
            Text(
              widget.call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.call_end,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    isCallMissed = true;
                    await callMethods.endCall(call: widget.call);
                  },
                ),
                SizedBox(width: 25),
                InkWell(
                    child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                        )),
                    onTap: () async {
                      isCallMissed = false;

                      addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);

                      await Permissions.cameraAndMicrophonePermissionsGranted()
                          ? nextScreen(context, CallScreen(call: widget.call))
                          // ignore: unnecessary_statements
                          : () {};
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
