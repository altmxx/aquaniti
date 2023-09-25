import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/dashboard/widgets/profile_stats_view.dart';
import 'package:aquaniti/features/dashboard/widgets/water_footprint_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(22.h),
              const ProfileStatsView(),
              verticalSpace(12.h),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.yourWaterFootprint,
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                ),
              ),
              verticalSpace(4.h),
              Container(
                padding: EdgeInsets.only(top: 12.h),
                width: 314.w,
                height: 296.h,
                decoration: BoxDecoration(
                    color: GlobalVariables.secondaryColor,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return WaterFootprintListTile();
                      },
                      itemCount: 3,
                      separatorBuilder: (ctx, i) => verticalSpace(12.h),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.only(left: 19.w)),
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.viewEntireHistory,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.buttonColor,
                          ),
                        ))
                  ],
                ),
              ),
              verticalSpace(12.h)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: GlobalVariables.primaryColor,
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }
}
