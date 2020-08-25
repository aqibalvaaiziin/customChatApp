import 'package:chatApp/db/log_repository.dart';
import 'package:chatApp/enum/user_state.dart';
import 'package:chatApp/provider/user_provider.dart';
import 'package:chatApp/resources/auth_methods.dart';
import 'package:chatApp/screen/login_page/login_page.dart';
import 'package:chatApp/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import './home_page.dart';

abstract class HomePageViewModel extends State<HomePage>
    with WidgetsBindingObserver {
  UserProvider userProvider;
  PageController pageController;
  AuthMethods _authMethods = AuthMethods();
  int currentPage = 0;

  void signOut() {
    _authMethods.signOut();
    nextScreenReplacement(context, LoginPage());
  }

  void onPageChangedAction(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUsersState(
                userId: currentUserId, userState: UserState.Online)
            : print("active state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUsersState(
                userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUsersState(
                userId: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUsersState(
                userId: currentUserId, userState: UserState.Offline)
            : print("detacth state");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUsersState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online,
      );
      LogRepository.init(isHive: true, dbName: userProvider.getUser.uid);
    });
    pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
