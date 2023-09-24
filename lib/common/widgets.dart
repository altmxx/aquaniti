// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aquaniti/constants/global_variables.dart';

Widget horizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget verticalSpace(double height) {
  return SizedBox(height: height);
}

class ThemeTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? hintTextColor;
  final String hintText;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final int maxLength;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final int maxLines;
  final bool enabled;
  const ThemeTextField(
      {super.key,
      this.validator,
      this.controller,
      this.hintText = "",
      this.obscureText = false,
      this.onChanged,
      this.fillColor,
      this.hintTextColor,
      this.maxLength = 50,
      this.prefix,
      this.suffix,
      this.maxLines = 1,
      this.enabled = true,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      enabled: enabled,
      minLines: 1,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.transparent)),
          counter: const SizedBox(),
          filled: true,
          fillColor: fillColor ?? Colors.white,
          suffixIcon: suffix,
          prefix: prefix,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          hintText: hintText,
          hintStyle: TextStyle(
              color: hintTextColor ?? GlobalVariables.hintTextColor,
              fontSize: 15.sp)),
    );
  }
}

class ThemeButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color? borderColor;
  final double borderRadius;
  final VoidCallback? onPressed;
  const ThemeButton({
    super.key,
    required this.child,
    this.color = GlobalVariables.buttonColor,
    this.borderRadius = 0,
    this.onPressed,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              side: borderColor == null
                  ? BorderSide.none
                  : BorderSide(color: borderColor!),
            ),
          ),
        ),
        child: child);
  }
}

class ThemeContainer extends StatelessWidget {
  final Color color;
  final double? height;
  final Widget? child;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsets padding;
  const ThemeContainer({
    Key? key,
    this.color = GlobalVariables.secondaryColor,
    this.height,
    this.child,
    this.border,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: color, border: border, borderRadius: borderRadius),
      child: child,
    );
  }
}
