
import 'package:chatApp/provider/image_upload_provider.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:chatApp/resources/auth_methods.dart';
import 'package:chatApp/screen/home_page/home_page.dart';
import 'package:chatApp/screen/login_page/login_page.dart';
import 'package:chatApp/screen/search_page/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthMethods _authMethods = AuthMethods();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImageUploadProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          '/search_screen': (context) => SearchPage(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: FutureBuilder(
            future: _authMethods.getCurrentUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return LoginPage();
              }
            }),
      ),
    );
  }
}
