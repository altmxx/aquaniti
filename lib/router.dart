import 'package:aquaniti/features/auth/screens/signIn_screen.dart';
import 'package:aquaniti/features/auth/screens/signUp_screen.dart';
import 'package:aquaniti/features/auth/screens/user_detail_screen.dart';
import 'package:aquaniti/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(builder: (_) => SignInScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => SignUpScreen());
    case UserDetailScreen.routeName:
      return MaterialPageRoute(builder: (_) => UserDetailScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exists'),
                ),
              ));
  }
}
