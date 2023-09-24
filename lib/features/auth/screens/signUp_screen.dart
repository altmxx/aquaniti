import 'dart:developer';

import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/auth/screens/signIn_screen.dart';
import 'package:aquaniti/features/auth/screens/user_detail_screen.dart';
import 'package:aquaniti/features/auth/services/authProvider.dart';
import 'package:aquaniti/features/auth/services/signIn_provider.dart';
// import 'package:aquaniti/models/appUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confPasswordController = TextEditingController();

  // bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final signInProvider = Provider.of<SignInProvider>(context);
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: GlobalVariables.primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(35.h),
                Container(
                  height: 206.33.h,
                  alignment: Alignment.center,
                  child:
                      Image.asset("assets/images/logo/AquaNit_Logo_White.png"),
                ),
                verticalSpace(33.67.h),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ThemeTextField(
                          controller: usernameController,
                          hintText: "Username",
                          validator: (val) {
                            if (val == "") {
                              return "Please enter username";
                            }
                          },
                        ),
                        verticalSpace(8.h),
                        ThemeTextField(
                          controller: emailController,
                          hintText: "Email",
                          validator: (val) {
                            if (val == "") {
                              return "Please enter email";
                            }
                          },
                        ),
                        verticalSpace(8.h),
                        ThemeTextField(
                          controller: passwordController,
                          obscureText: true,
                          hintText: "Password",
                          validator: (val) {
                            if (val == "") {
                              return "Please enter password";
                            }
                          },
                        ),
                        verticalSpace(8.h),
                        ThemeTextField(
                          controller: confPasswordController,
                          obscureText: true,
                          hintText: "Confirm Password",
                          validator: (val) {
                            if (passwordController.text.isEmpty) {
                              return "No password entered";
                            }
                            if (passwordController.text != val) {
                              return "Passwords dont match";
                            } else if (val == "") {
                              return "Please confirm the password";
                            }
                          },
                        ),
                      ],
                    )),
                verticalSpace(12.h),
                SizedBox(
                  width: double.infinity,
                  child: ThemeButton(
                    borderRadius: 15,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // _isLoading = true;
                        signInProvider.username = usernameController.text;
                        signInProvider.email = emailController.text;
                        var userCreds =
                            await authProvider.registerUserWithEmail(
                                usernameController.text,
                                passwordController.text);
                        //     .then((userCred) {
                        //   log(userCred!.user!.uid.toString());
                        //   signinProvider.uid = userCred.user!.uid;
                        //   Navigator.of(context)
                        //       .pushNamed(UserDetailScreen.routeName);
                        // }
                        // );
                        signInProvider.uid = userCreds!.user!.uid;
                        log(signInProvider.uid);
                        Navigator.of(context)
                            .pushNamed(UserDetailScreen.routeName);
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                verticalSpace(44.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Signed Up?",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignInScreen.routeName);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: GlobalVariables.buttonColor),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
