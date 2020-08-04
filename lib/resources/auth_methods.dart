import 'package:chatApp/enum/user_state.dart';
import 'package:chatApp/helper/const_config.dart';
import 'package:chatApp/helper/utils.dart';
import 'package:chatApp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection(USERS_COLLECTION);
  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<User> getUserDetail() async {
    FirebaseUser currentUser = await getCurrentUser();
    DocumentSnapshot documentSnapshot =
        await _userCollection.document(currentUser.uid).get();
    return User.fromMap(documentSnapshot.data);
  }

  Future<User> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _userCollection.document(id).get();
      return User.fromMap(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication _signInAuth =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _signInAuth.idToken,
      accessToken: _signInAuth.accessToken,
    );

    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    return docs.length == 0 ? true : false;
  }

  Future<void> addDatatoDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);
    user = User(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      username: username,
      photo: currentUser.photoUrl,
    );
    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<User>> getAllUser(FirebaseUser user) async {
    List<User> userList = List<User>();
    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != user.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

  void setUsersState({
    @required String userId,
    @required UserState userState,
  }) {
    int stateNum = Utils.stateToNum(userState);
    _userCollection.document(userId).updateData({
      "state": stateNum,
    });
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();
}
