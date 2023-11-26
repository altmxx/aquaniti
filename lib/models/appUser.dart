import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String? uid;
  String? name;
  String? username;
  String? email;
  String? state;
  String? city;
  int? pinCode;
  String? languagePreference;
  String? profilePhoto;
  AppUser({
    this.uid,
    this.name,
    this.username,
    this.email,
    this.state,
    this.city,
    this.pinCode,
    this.languagePreference,
    this.profilePhoto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'username': username,
      'email': email,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'languagePreference': languagePreference,
      'profilePhoto': profilePhoto,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      pinCode: map['pinCode'] != null ? map['pinCode'] as int : null,
      languagePreference: map['languagePreference'] != null
          ? map['languagePreference'] as String
          : null,
      profilePhoto:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
