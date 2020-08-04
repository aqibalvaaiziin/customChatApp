import 'package:flutter/material.dart';
import './home_page_view.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key key, this.email}) : super(key: key);

  @override
  HomePageView createState() => new HomePageView();
}
