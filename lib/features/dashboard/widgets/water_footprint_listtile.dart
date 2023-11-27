// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/features/dashboard/services/dashboard_provider.dart';
import 'package:aquaniti/models/waterFootprint.dart';

class WaterFootprintListTile extends StatelessWidget {
  final WaterFootprint waterFootprint;
  const WaterFootprintListTile({
    Key? key,
    required this.waterFootprint,
  }) : super(key: key);

  String capitalizeFirstLetter(String input) =>
      input.isNotEmpty ? input[0].toUpperCase() + input.substring(1) : input;

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
            decoration: BoxDecoration(
              color: Colors.grey,
              image: waterFootprint.imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(waterFootprint.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          horizontalSpace(12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalizeFirstLetter(waterFootprint.product),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${AppLocalizations.of(context)!.purchasedDate}: ${DateFormat.yMMMd().format(waterFootprint.date!)}",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${AppLocalizations.of(context)!.yourWaterFootprint}: ${waterFootprint.totalWaterFootprint}",
                style: TextStyle(
                  fontSize: 12.sp,
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
