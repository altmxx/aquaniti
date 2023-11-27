import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/features/marketplace/widgets/marketplace_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketPlaceScreen extends StatelessWidget {
  const MarketPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            Container(
              width: 316.w,
              height: 180.h,
              color: Colors.grey,
            ),
            verticalSpace(27.h),
            MarketPlaceWidget(),
          ],
        ),
      )),
    );
  }
}
