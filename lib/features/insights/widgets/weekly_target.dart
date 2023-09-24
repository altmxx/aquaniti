import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeeklyTarget extends StatelessWidget {
  const WeeklyTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      width: 314.w,
      height: 215.h,
      decoration: BoxDecoration(
        color: GlobalVariables.secondaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Weekly Target",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(4.h),
            SizedBox(
              width: 270.w,
              child: Text(
                "Setting a weekly target helps reduce your water footprint.",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            verticalSpace(8.h),
            Text(
              "Sept 17-23",
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            verticalSpace(12.h),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: "135 ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "of",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " 150",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                ),
                horizontalSpace(16.w),
                Container(
                  width: 205.w,
                  height: 12.w,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: GlobalVariables.buttonColor,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Container(
                    width: 105.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: GlobalVariables.primaryColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                )
              ],
            ),
            verticalSpace(15.h),
            SizedBox(
              width: 270.w,
              child: Text(
                "By keeping the water footprint near the average impacts environment in a beneficial way. Your efforts combined with everyone else paves the way to a greener future",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
