// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:aquaniti/constants/global_variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          titlesData: FlTitlesData(
              // show: false,
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: _bottomTitles)),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                    toY: lastSevenDaysData[0]['total'] as double,
                    color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                    toY: lastSevenDaysData[1]['total'],
                    color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                    toY: lastSevenDaysData[2]['total'],
                    color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                    toY: lastSevenDaysData[3]['total'],
                    color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                    toY: lastSevenDaysData[4]['total'],
                    color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                    toY: lastSevenDaysData[5]['total'],
                    color: GlobalVariables.primaryColor),
              ],
            ),
            BarChartGroupData(
              x: 6,
              barRods: [
                BarChartRodData(
                    toY: lastSevenDaysData[6]['total'],
                    color: GlobalVariables.primaryColor),
              ],
            ),
            // Add more BarChartGroupData here
          ],
          borderData: FlBorderData(show: true),
          groupsSpace: 20),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Mon';
              break;
            case 1:
              text = 'Tue';
              break;
            case 2:
              text = 'Wed';
              break;
            case 3:
              text = 'Thu';
              break;
            case 4:
              text = 'Fri';
              break;
            case 5:
              text = 'Sat';
              break;
            case 6:
              text = 'Sun';
              break;
          }

          return Text(
            text,
            style: TextStyle(fontSize: 8.sp),
          );
        },
      );
}
