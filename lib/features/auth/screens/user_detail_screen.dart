import 'dart:developer';

import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/auth/screens/signIn_screen.dart';
import 'package:aquaniti/features/auth/services/authProvider.dart';
import 'package:aquaniti/features/auth/services/signIn_provider.dart';
import 'package:aquaniti/models/appUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatefulWidget {
  static const routeName = "/userDetailScreen";
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var pincodeController = TextEditingController();

  String state = "Select State";
  String languagePreference = "Select Language";

  final List<String> _indianStates = [
    "Select State",
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    // ... add all other states
  ];

  final List<String> _languages = [
    "Select Language",
    'English',
    'Hindi',
    'Tamil',
    'Telugu'
  ]; // You can extend this list as needed

  // final signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    final signInProvider = Provider.of<SignInProvider>(context);
    log("In Details Screen, Uid is ${signInProvider.appUser.uid}");
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 56.94.h,
                    alignment: Alignment.center,
                    child:
                        Image.asset("assets/images/logo/AquaNit_Logo_Blue.png"),
                  ),
                  Text(
                    "Almost There",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.primaryColor,
                    ),
                  ),
                  verticalSpace(4.h),
                  Text(
                    "Tell us a few things about yourself",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: GlobalVariables.textColor,
                    ),
                  ),
                  verticalSpace(23.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ThemeTextField(
                          controller: nameController,
                          hintText: "Name",
                          fillColor: GlobalVariables.secondaryColor,
                          validator: (val) {
                            if (nameController.text.isEmpty) {
                              return "Enter your name";
                            }
                          },
                        ),
                        verticalSpace(6.h),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: GlobalVariables.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: Colors.black)),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            value: state,
                            items: _indianStates
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: GlobalVariables.hintTextColor),
                                  ));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                state = newValue!;
                              });
                            },
                          )),
                        ),
                        verticalSpace(12.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 168.w,
                              child: ThemeTextField(
                                controller: cityController,
                                hintText: "City",
                                fillColor: GlobalVariables.secondaryColor,
                                validator: (val) {
                                  if (cityController.text.isEmpty) {
                                    return "Enter your City";
                                  }
                                },
                              ),
                            ),
                            horizontalSpace(7.w),
                            SizedBox(
                              width: 120.w,
                              child: ThemeTextField(
                                controller: pincodeController,
                                hintText: "Pin Code",
                                fillColor: GlobalVariables.secondaryColor,
                                validator: (val) {
                                  if (pincodeController.text.isEmpty) {
                                    return "Enter your Pin Code";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(6.h),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: GlobalVariables.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: Colors.black)),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            value: languagePreference,
                            items: _languages
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: GlobalVariables.hintTextColor),
                                  ));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                languagePreference = newValue!;
                              });
                            },
                          )),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(32.h),
                  SizedBox(
                    width: double.infinity,
                    child: ThemeButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              state != "Select State" &&
                              languagePreference != "Select Language") {
                            // signInProvider.name = nameController.text;
                            // signInProvider.state = state;
                            // signInProvider.city = cityController.text;
                            // signInProvider.pincode = pincodeController.text;
                            // signInProvider.state = state;
                            // signInProvider.language = languagePreference;
                            signInProvider.appUser.name = nameController.text;
                            signInProvider.appUser.state = state;
                            signInProvider.appUser.city = cityController.text;
                            signInProvider.appUser.pinCode =
                                int.parse(pincodeController.text);
                            signInProvider.appUser.languagePreference =
                                languagePreference;
                            // log(signInProvider.uid);
                            log("the data stored in signIn Provider is${signInProvider.appUser.toMap()}");
                            await AuthenticationProvider.registerUser(
                                signInProvider.appUser);
                            Fluttertoast.showToast(
                                msg:
                                    "User has been created. Login to continue");
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushReplacementNamed(SignInScreen.routeName);
                            }
                          }
                        },
                        borderRadius: 20.r,
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  verticalSpace(90.h),
                  SizedBox(
                    child: Image.asset(
                        "assets/images/logo/AquaNiti_Text_Blue.png"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
