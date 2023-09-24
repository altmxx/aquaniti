import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/insights/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaterFootPrintGraph extends StatelessWidget {
  final List<Map<String, dynamic>> lastSevenDaysData;
  const WaterFootPrintGraph(this.lastSevenDaysData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314.w,
      height: 157.h,
      padding: EdgeInsets.only(left: 20.w, top: 12.h, right: 25.w),
      decoration: BoxDecoration(
        color: GlobalVariables.secondaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Water Footprint",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          verticalSpace(4.h),
          Text(
            "Last 7 days",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
          ),
          verticalSpace(7.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "10L",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: GlobalVariables.buttonColor),
                  ),
                  Text(
                    "Today",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: GlobalVariables.buttonColor),
                  )
                ],
              ),
              SizedBox(
                  height: 78.h,
                  width: 206.w,
                  child: BarGraph(
                    lastSevenDaysData: lastSevenDaysData,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
