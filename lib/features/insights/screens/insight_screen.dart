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

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final insightsProvider = Provider.of<InsightsProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(30.h),
              StreamBuilder<QuerySnapshot>(
                  stream: insightsProvider.getStatsData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
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
              // StreamBuilder<QuerySnapshot>(
              //     stream: insightsProvider.getLastSevenDaysData(),
              //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return CircularProgressIndicator();
              //       }
              //       if (snapshot.hasError) {
              //         return Text("Error: ${snapshot.error}");
              //       }
              //       List<Map<String, dynamic>> lastSevenDaysData = [];
              //       final documents = snapshot.data!.docs;
              //       final today = DateTime.now();
              //       for (int i = 0; i < 7; i++) {
              //         final date = today.subtract(Duration(days: i));
              //         final dayName = DateFormat("EEEE").format(date);
              //         double totalWaterFootprint = 0.0;

              //         for (final doc in documents) {
              //           final docDate =
              //               DateTime.fromMillisecondsSinceEpoch(doc['date']);
              //           log("${docDate.year} ${docDate.month} ${docDate.day}");
              //           if (docDate.year == date.year &&
              //               docDate.month == date.month &&
              //               docDate.day == docDate.day) {
              //             totalWaterFootprint += doc['total_water_footprint'];
              //           }
              //         }
              //         lastSevenDaysData.add({
              //           'dayName': dayName,
              //           'totalWaterFootprint': totalWaterFootprint
              //         });
              //       }
              //       return WaterFootPrintGraph(lastSevenDaysData);
              //     }),
              const WaterFootPrintGraph([{}]),
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
