// import 'dart:math';

import 'dart:developer';
// import 'dart:js';

import 'package:aquaniti/features/auth/services/signIn_provider.dart';
import 'package:aquaniti/models/appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

final usersDB = FirebaseFirestore.instance.collection("users");

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isAuthenticated = false;
  User? _user;

  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AuthProvider() {
    loadAuthState();
  }

  void setAuthenticated(bool isAuthenticated, User? user) {
    _isAuthenticated = isAuthenticated;
    _user = user;
  }

  Future<void> loadAuthState() async {
    var _prefs = await SharedPreferences.getInstance();
    _isAuthenticated = _prefs.getBool('isAuthenticated') ?? false;
    notifyListeners();
  }

  Future<void> saveAuthState(bool isAuthenticated, {String? uid}) async {
    var _isAuthenticated = isAuthenticated;
    var _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('isAuthenticated', isAuthenticated);
    if (uid != null) {
      await _prefs.setString('uid', uid);
    }
    notifyListeners();
  }

  //Creates a doc in the firestore for our user data;
  static Future<void> registerUser(AppUser user) async {
    log(user.uid!);
    await usersDB.doc(user.uid).set(user.toMap());
  }

  Future<AppUser> fetchUserDatafromFirebaseFirestore(String uid) async {
    var doc = await usersDB.doc(uid).get();
    if (doc.data() != null) {
      return AppUser.fromMap(doc.data()!);
    } else {
      log("No data found in the firebase firestore with Uid $uid");
      return AppUser();
    }
  }

  Future<UserCredential?> registerUserWithEmail(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: "$email@aquaniti.com", password: password);
      //Creating a doc in the firestore to store our user data like username and uid->(initially)
      registerUser(AppUser(username: email, uid: result.user!.uid));

      return result;
    } on FirebaseAuthException catch (firebaseAuthException) {
      if (firebaseAuthException.code == "email-already-in-use") {
        Fluttertoast.showToast(msg: "Username already taken");
        print(firebaseAuthException.message);
        return null;
      } else {
        Fluttertoast.showToast(msg: firebaseAuthException.message.toString());
        print(firebaseAuthException.message);
        return null;
      }
    }
  }

  Future<UserCredential?> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: "$email@aquaniti.com", password: password);
      setAuthenticated(true, result.user);
      saveAuthState(true, uid: result.user!.uid);
      // Provider.of<SignInProvider>(context, listen: false).uid =
      //     result.user!.uid;
      // if (context.mounted) {
      //   Provider.of<SignInProvider>(context, listen: false).isAuth = true;
      // } else {
      //   log("Not Mounted");
      // }
      return result;
    } on FirebaseAuthException catch (firebaseAuthException) {
      Fluttertoast.showToast(msg: firebaseAuthException.message.toString());
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    setAuthenticated(false, null);
    saveAuthState(false);
  }
}
