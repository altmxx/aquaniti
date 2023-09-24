// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/global_variables.dart';

class UserStats extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const UserStats({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documents = snapshot.data!.docs;
    //Calculate Todays water footprint
    log(documents.length.toString());
    final today = DateTime.now();
    final todayWaterFootprint = documents
        .where((doc) {
          final docDate = DateTime.fromMillisecondsSinceEpoch(doc['date']);
          return docDate.year == today.year &&
              docDate.month == today.month &&
              docDate.day == today.day;
        })
        .map((doc) => doc['total_water_footprint'] as double)
        .fold<double>(0, (sum, footprint) => sum + footprint);

    //Calculate Average Water Footprint
    final averageWaterFootprint = documents
            .map((doc) => doc['total_water_footprint'] as double)
            .fold<double>(0, (sum, footprint) => sum + footprint) /
        documents.length;

    //Calculate Monthly Water Footprint
    final currentMonth = DateTime(today.year, today.month);
    final monthlyWaterFootprint = documents
        .where((doc) {
          final docDate = DateTime.fromMicrosecondsSinceEpoch(doc['date']);
          return docDate.isAtSameMomentAs(currentMonth) ||
              docDate.isAfter(currentMonth);
        })
        .map((doc) => doc['total_water_footprint'] as int)
        .fold(0, (sum, footprint) => sum + footprint);
    return Container(
      width: 314.w,
      height: 138.h,
      decoration: BoxDecoration(
        color: GlobalVariables.secondaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      todayWaterFootprint.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Today's\nWater\nFootprint",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      averageWaterFootprint.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Average\nWater\nFootprint",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (monthlyWaterFootprint).toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Monthly\nWater\nFootprint",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 39.w, right: 27.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Water Footprint is in Liters",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Container(
                  width: 50.w,
                  height: 20.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: GlobalVariables.buttonColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
