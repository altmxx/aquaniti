import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String _uid = "c4wQT8xnxNOlT0fZCYgEiiykESH3";
  String _username = '';
  String _email = "";
  String _name = "";
  String _state = "";
  String _city = "";
  String _pinCode = "";
  String _language = "";

  String get uid => _uid;
  String get username => _username;
  String get email => _email;
  String get name => _name;
  String get state => _state;
  String get city => _city;
  String get pincode => _pinCode;
  String get language => _language;

  set uid(String value) {
    _uid = value;
    notifyListeners();
  }

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set state(String value) {
    _state = value;
    notifyListeners();
  }

  set city(String value) {
    _city = value;
    notifyListeners();
  }

  set pincode(String value) {
    _pinCode = value;
    notifyListeners();
  }

  set language(String value) {
    _language = value;
    notifyListeners();
  }
}
