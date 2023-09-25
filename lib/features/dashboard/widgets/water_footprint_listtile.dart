import 'package:aquaniti/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaterFootprintListTile extends StatelessWidget {
  const WaterFootprintListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 246.w,
      height: 70.h,
      padding: EdgeInsets.only(left: 19.w),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            color: Colors.grey,
          ),
          horizontalSpace(12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Water Bottle",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${AppLocalizations.of(context)!.purchasedDate}: 19/09/23",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${AppLocalizations.of(context)!.yourWaterFootprint}: 15",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
