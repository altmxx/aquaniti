import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Choose the Language you understand best in"),
              verticalSpace(12.h),
              SizedBox(
                width: double.infinity,
                child: ThemeButton(
                  borderRadius: 20.r,
                  child: const Text(
                    "Hindi",
                    style: TextStyle(color: Colors.white),
                  ),
                  // onPressed: () => MyApp.of(context)!
                  //     .setLocale(Locale.fromSubtags(languageCode: 'hi')),
                ),
              ),
            ],
          )),
    );
  }
}
