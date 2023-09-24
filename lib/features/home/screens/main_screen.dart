import 'dart:developer';

import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/dashboard/screens/dashboard_screen.dart';
import 'package:aquaniti/features/home/screens/home_screen.dart';
import 'package:aquaniti/features/insights/screens/insight_screen.dart';
import 'package:aquaniti/features/profile/screens/profile_screen.dart';
import 'package:aquaniti/features/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var currentIndex = 1;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Home",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              )
            : currentIndex == 1
                ? Text(
                    "Dashboard",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  )
                : currentIndex == 2
                    ? Text(
                        "Insights",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )
                    : currentIndex == 3
                        ? Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
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
              items: const [
                BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.home),
                    label: "Home"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.dashboard_outlined),
                    label: "Dashboard"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.analytics),
                    label: "Analytics"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.person),
                    label: "Profile"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
