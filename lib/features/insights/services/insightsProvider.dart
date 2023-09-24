import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:aquaniti/models/waterFootprint.dart';
import 'package:flutter/material.dart';

// import '../../auth/services/authProvider.dart';

class InsightsProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  var _waterFootprint = WaterFootprint(
      id: "",
      category: "",
      product: "",
      blueWaterFootprint: 0,
      greyWaterFootprint: 0,
      greenWaterFootprint: 0,
      totalWaterFootprint: 0);
  var _todayWaterFootprint = 0.0;
  var _monthlyWaterFootprint = 0.0;
  var _averageWaterFootprint = 0.0;

  WaterFootprint get waterFootprint => _waterFootprint;
  double get todayWaterFootprint => _todayWaterFootprint;
  double get monthlyWaterFootprint => _monthlyWaterFootprint;
  double get averageWaterFootprint => _averageWaterFootprint;

  set todayWaterFootprint(double value) {
    _todayWaterFootprint = value;
    notifyListeners();
  }

  set monthlyWaterFootprint(double value) {
    _monthlyWaterFootprint = value;
    notifyListeners();
  }

  set averageWaterFootprint(double value) {
    _averageWaterFootprint = value;
    notifyListeners();
  }

  Stream<QuerySnapshot> getStatsData() {
    var snapshot = firestore
        .collection('users')
        .doc("c4wQT8xnxNOlT0fZCYgEiiykESH3")
        .collection('waterfootprints')
        .snapshots();
    // notifyListeners();
    return snapshot;
  }

  Stream<QuerySnapshot> getLastSevenDaysData() {
    var snapshot = firestore
        .collection("users")
        .doc("c4wQT8xnxNOlT0fZCYgEiiykESH3")
        .collection("waterfootprints")
        .snapshots();
    return snapshot;
  }

  Future<void> getWaterFootprintData(String product) async {
    var response = await http.get(Uri.parse(
        "https://aquaniti-default-rtdb.asia-southeast1.firebasedatabase.app/data.json"));
    // log(response.body);
    var data = jsonDecode(response.body) as List<dynamic>;
    for (int i = 0; i < data.length; i++) {
      if (data[i]['Product'] == product.toLowerCase()) {
        log(WaterFootprint.fromMap(data[i]).toString());
        _waterFootprint = WaterFootprint.fromMap(data[i]);
        var waterFootprintMap = _waterFootprint.toMap();
        waterFootprintMap['date'] = DateTime.now().millisecondsSinceEpoch;
        firestore
            .collection("users")
            .doc("c4wQT8xnxNOlT0fZCYgEiiykESH3")
            .collection("waterfootprints")
            .add(waterFootprintMap);
        notifyListeners();
        return;
      }
    }
    log("record not found");
    _waterFootprint = WaterFootprint(
        id: "",
        category: "",
        product: "",
        blueWaterFootprint: 0,
        greyWaterFootprint: 0,
        greenWaterFootprint: 0,
        totalWaterFootprint: 0);
    notifyListeners();
  }
}
