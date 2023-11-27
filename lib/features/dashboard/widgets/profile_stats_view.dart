// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aquaniti/common/widgets.dart';

import '../../../constants/global_variables.dart';

class ProfileStatsView extends StatelessWidget {
  final String name;
  final String city;
  final String state;
  const ProfileStatsView({
    Key? key,
    required this.name,
    required this.city,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314.w,
      height: 168.h,
      decoration: BoxDecoration(
        color: GlobalVariables.secondaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 19.w, top: 12.h),
        child: Column(children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.white,
              ),
              horizontalSpace(24.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(city),
                  Text(state),
                ],
              )
            ],
          ),
          verticalSpace(24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xff88C20E),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "90",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 47,
                    child: Text(
                      "Personal WF",
                      style: TextStyle(fontSize: 9.sp),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xffD54646),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "150",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 47,
                    child: Text(
                      "Local WF",
                      style: TextStyle(fontSize: 9.sp),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  children: [
                    Text(
                      "15",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Leaderboard",
                      style: TextStyle(fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
