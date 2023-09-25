import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/main.dart';
import 'package:aquaniti/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
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
                      "हिंदी",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      MyApp.setLocale(context,
                          const Locale.fromSubtags(languageCode: 'hi'));
                    }),
              ),
              SizedBox(
                width: double.infinity,
                child: ThemeButton(
                    borderRadius: 20.r,
                    child: const Text(
                      "English",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      MyApp.setLocale(context,
                          const Locale.fromSubtags(languageCode: 'en'));
                    }),
              ),
            ],
          )),
    );
  }
}
