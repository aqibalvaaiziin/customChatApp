import 'package:chatApp/helper/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesData {
  Future setUserLogin(FirebaseUser user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
     String username = Utils.getUsername(user.email);
    sp.setString("id", user.uid);
    sp.setString("name", user.displayName);
    sp.setString("email", user.email);
    sp.setString("photo", user.photoUrl);
    sp.setString("username", username);
  }
}
