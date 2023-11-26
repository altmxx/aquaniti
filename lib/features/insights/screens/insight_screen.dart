import 'dart:developer';

import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/camera/screens/camera_screen.dart';
import 'package:aquaniti/features/insights/services/insightsProvider.dart';
import 'package:aquaniti/features/insights/widgets/user_stats.dart';
import 'package:aquaniti/features/insights/widgets/water_footprint_graph.dart';
import 'package:aquaniti/features/insights/widgets/weekly_target.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../auth/services/signIn_provider.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);
    final insightsProvider =
        Provider.of<InsightsProvider>(context, listen: false);
    log("SignINProvider's uid is (in insightsScreen) ${signInProvider.appUser.uid}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(30.h),
              StreamBuilder<QuerySnapshot>(
                  stream: insightsProvider
                      .getStatsData(signInProvider.appUser.uid!),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData) {
                      return Text("There is no data");
                    }
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    return UserStats(
                      snapshot: snapshot,
                    );
                  }),
              verticalSpace(24.h),
              WeeklyTarget(),
              verticalSpace(24.h),
              StreamBuilder(
                  stream: insightsProvider.waterFootprintStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("No Waterfootprint data available");
                    } else {
                      log(insightsProvider.dailyTotals.toString());
                      return WaterFootPrintGraph(snapshot.data!);
                    }
                  }),
              // const WaterFootPrintGraph([{}]),
              verticalSpace(12.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CameraScreen()));
        },
        backgroundColor: GlobalVariables.primaryColor,
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }
}
