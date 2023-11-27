import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/features/marketplace/screens/marketplace_screen.dart';
import 'package:aquaniti/models/marketplace_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketPlaceWidget extends StatelessWidget {
  // final MarketPlaceItem marketPlaceItem;
  const MarketPlaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.w,
      height: 201.h,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:  Color(0XFFDAF0FF),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 90.h,
            width: 134.w,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          Row(
            children: [
              Text(
                "Bottle",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              horizontalSpace(6.w),
              Text(
                "bisleri",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              horizontalSpace(37.w),
              Text(
                "₹25/-",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text("Water FootPrint: 0.2 L")
        ],
      ),
    );
  }
}
