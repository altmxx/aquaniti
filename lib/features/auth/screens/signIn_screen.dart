import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/auth/screens/signUp_screen.dart';
import 'package:aquaniti/features/auth/services/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/signInScreen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: GlobalVariables.primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(70.h),
                Container(
                  height: 206.33.h,
                  alignment: Alignment.center,
                  child:
                      Image.asset("assets/images/logo/AquaNit_Logo_White.png"),
                ),
                verticalSpace(48.67.h),
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
                          } else {
                            return "";
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
                          } else {
                            return "";
                          }
                        },
                      )
                    ],
                  ),
                ),
                verticalSpace(8.h),
                SizedBox(
                  width: double.infinity,
                  child: ThemeButton(
                    borderRadius: 15,
                    onPressed: () async {
                      if (!isLoading) {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await authProvider.signInWithEmail(
                              usernameController.text, passwordController.text);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                verticalSpace(115.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User?",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignUpScreen.routeName);
                        },
                        child: Text(
                          "Create Account",
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
