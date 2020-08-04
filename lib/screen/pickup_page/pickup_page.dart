import 'package:chatApp/models/call.dart';
import 'package:flutter/material.dart';
import './pickup_page_view.dart';

class PickupPage extends StatefulWidget {
  final Call call;

  const PickupPage({Key key, this.call}) : super(key: key);
  @override
  PickupPageView createState() => new PickupPageView();
}
