import 'package:chatApp/models/call.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:chatApp/resources/call_methods.dart';
import 'package:chatApp/screen/pickup_page/pickup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupScreen extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupScreen({Key key, this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return userProvider != null && userProvider.getUser != null
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.getUser.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data != null) {
                Call call = Call.fromMap(snapshot.data.data);
                if (!call.hasDialled) {
                  return PickupPage(call: call);
                }
                return scaffold;
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
