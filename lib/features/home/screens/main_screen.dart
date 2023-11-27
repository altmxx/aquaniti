import 'dart:developer';

import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/auth/services/signIn_provider.dart';
import 'package:aquaniti/features/dashboard/screens/dashboard_screen.dart';
import 'package:aquaniti/features/home/screens/home_screen.dart';
import 'package:aquaniti/features/insights/screens/insight_screen.dart';
import 'package:aquaniti/features/profile/screens/profile_screen.dart';
import 'package:aquaniti/features/settings/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/services/dashboard_provider.dart';

var currentIndex = 1;

class MainScreen extends StatefulWidget {
  static const routeName = "/mainScreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // var _isInit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);
    SharedPreferences.getInstance().then((prefs) {
      var uid = prefs.getString("uid");
      if (uid != null) {
        log(uid);
        final signInProvider =
            Provider.of<SignInProvider>(context, listen: false);
        signInProvider.fetchAndSetUser(uid);
        dashboardProvider.getLatestWaterFootprintsOfUser(uid);
      }
    });
    setState(() {});
    // final signInProvider = Provider.of<SignInProvider>(context, listen: false);
    // signInProvider.fetchAndSetUser(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);
    // if (_isInit) {
    //   signInProvider.fetchAndSetUser(FirebaseAuth.instance.currentUser!.uid);
    //   _isInit = false;
    // }

    log('In the main Screen, the app user details are ${signInProvider.appUser.toMap()}');
    return signInProvider.appUser.uid == null
        ? const Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ))
        : Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                    },
                  ),
                )
              ],
              title: currentIndex == 0
                  ? Text(
                      AppLocalizations.of(context)!.home,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    )
                  : currentIndex == 1
                      ? Text(
                          AppLocalizations.of(context)!.dashboard,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.sp),
                        )
                      : currentIndex == 2
                          ? Text(
                              AppLocalizations.of(context)!.insights,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.sp),
                            )
                          : currentIndex == 3
                              ? Text(
                                  AppLocalizations.of(context)!.profile,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                )
                              : const Text("App Bar"),
              backgroundColor: GlobalVariables.primaryColor,
              foregroundColor: Colors.white,
            ),
            body: IndexedStack(
              index: currentIndex,
              children: [
                HomeScreen(),
                DashboardScreen(),
                InsightsScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: GlobalVariables.primaryColor,
                  height: 0.5,
                ),
                SizedBox(
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: GlobalVariables.primaryColor,
                    selectedItemColor: GlobalVariables.buttonColor,
                    unselectedItemColor: Colors.white,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: currentIndex,
                    selectedLabelStyle: TextStyle(fontSize: 12.sp),
                    unselectedLabelStyle: TextStyle(fontSize: 12.sp),
                    onTap: (i) {
                      setState(() {
                        currentIndex = i;
                        log(currentIndex.toString());
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                          backgroundColor: Colors.white,
                          icon: const Icon(Icons.home),
                          label: AppLocalizations.of(context)!.home),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.white,
                          icon: const Icon(Icons.dashboard_outlined),
                          label: AppLocalizations.of(context)!.dashboard),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.white,
                          icon: const Icon(Icons.analytics),
                          label: AppLocalizations.of(context)!.analytics),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.white,
                          icon: const Icon(Icons.person),
                          label: AppLocalizations.of(context)!.profile),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
