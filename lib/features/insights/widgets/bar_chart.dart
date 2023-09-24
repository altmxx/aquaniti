// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:aquaniti/constants/global_variables.dart';

class BarGraph extends StatelessWidget {
  final List<Map<String, dynamic>> lastSevenDaysData;
  const BarGraph({
    Key? key,
    required this.lastSevenDaysData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.center,
          titlesData: const FlTitlesData(
            show: false,
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(toY: 5, color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(toY: 7, color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(toY: 18, color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(toY: 12, color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(toY: 8, color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(toY: 25, color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 6,
              barRods: [
                BarChartRodData(toY: 15, color: GlobalVariables.primaryColor),
              ],
            ),
            // Add more BarChartGroupData here
          ],
          // barGroups: lastSevenDaysData.asMap().entries.map((entry) {
          //   // log(lastSevenDaysData.toString());
          //   final index = entry.key;
          //   final data = entry.value;
          //   final dayName = data['dayName'];
          //   final totalWaterFootprint = data['totalWaterFootprint'];

          //   return BarChartGroupData(
          //     x: index,
          //     barRods: [
          //       BarChartRodData(
          //         toY: totalWaterFootprint,
          //         color: GlobalVariables.primaryColor,
          //       ),
          //     ],
          //   );
          // }).toList(),
          borderData: FlBorderData(show: true),
          groupsSpace: 16),
    );
  }
}
