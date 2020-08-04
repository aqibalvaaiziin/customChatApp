import 'package:chatApp/models/user.dart';
import 'package:flutter/material.dart';
import './chat_page_view.dart';
class ChatPage extends StatefulWidget {
  final User receiver;

  const ChatPage({Key key, this.receiver}) : super(key: key);
  @override
  ChatPageView createState() => new ChatPageView();
}