import 'package:aquaniti/features/auth/services/authProvider.dart';
import 'package:aquaniti/models/appUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  AppUser _appUser = AppUser();
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  bool? _isAuth = false;
  // String _uid = "";
  // String _username = '';
  // String _email = "";
  // String _name = "";
  // String _state = "";
  // String _city = "";
  // String _pinCode = "";
  // String _language = "";

  AppUser get appUser => _appUser;
  // bool get isAuth => _isAuth!;
  // String get uid => _uid;
  // String get username => _username;
  // String get email => _email;
  // String get name => _name;
  // String get state => _state;
  // String get city => _city;
  // String get pincode => _pinCode;
  // String get language => _language;

  set appUser(AppUser user) {
    _appUser = user;
    notifyListeners();
  }

  // set uid(String value) {
  //   _uid = value;
  //   notifyListeners();
  // }

  // set isAuth(bool value) {
  //   _isAuth = value;
  // }

  // set username(String value) {
  //   _username = value;
  //   notifyListeners();
  // }

  // set email(String value) {
  //   _email = value;
  //   notifyListeners();
  // }

  // set name(String value) {
  //   _name = value;
  //   notifyListeners();
  // }

  // set state(String value) {
  //   _state = value;
  //   notifyListeners();
  // }

  // set city(String value) {
  //   _city = value;
  //   notifyListeners();
  // }

  // set pincode(String value) {
  //   _pinCode = value;
  //   notifyListeners();
  // }

  // set language(String value) {
  //   _language = value;
  //   notifyListeners();
  // }

  void fetchAndSetUser(String uid) async {
    var docSnap = await usersDB.doc(uid).get();
    if (docSnap.data() != null) {
      _appUser = AppUser.fromMap(docSnap.data()!);
    }
    notifyListeners();
  }
}
