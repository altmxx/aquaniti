import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:aquaniti/models/waterFootprint.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

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
  List<Map<String, dynamic>> _dailyTotals = [];
  StreamSubscription<QuerySnapshot>? _streamSubscription;

  List<Map<String, dynamic>> get dailyTotals => _dailyTotals;
  Stream<List<Map<String, dynamic>>> get waterFootprintStream =>
      Stream.value(_dailyTotals);
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

  InsightsProvider(String? userId) {
    if (userId != null) {
      _streamSubscription = firestore
          .collection("users")
          .doc(userId)
          .collection("waterfootprints")
          .snapshots()
          .listen((querySnapshot) {
        fetchWaterFootprintData(userId);
      });
    }
  }

  Future<void> fetchWaterFootprintData(String userId) async {
    try {
      final now = DateTime.now();
      final last7Days = now.subtract(const Duration(days: 7));

      final querySnapshot = await firestore
          .collection("users")
          .doc(userId)
          .collection("waterfootprints")
          .where('date', isGreaterThan: last7Days.millisecondsSinceEpoch)
          .get();

      final filteredDocs = querySnapshot.docs;

      final dailyTotals = Map<String, dynamic>.from({
        'Monday': 0.0,
        'Tuesday': 0.0,
        'Wednesday': 0.0,
        'Thursday': 0.0,
        'Friday': 0.0,
        'Saturday': 0.0,
        'Sunday': 0.0,
      });

      filteredDocs.forEach((doc) {
        final docDate = DateTime.fromMillisecondsSinceEpoch(doc['date']);
        final dayOfWeek = docDate.weekday;
        final dayOfWeekString = _getDayOfWeekString(dayOfWeek);
        dailyTotals[dayOfWeekString] += doc['total_water_footprint'];
      });

      _dailyTotals = dailyTotals.entries
          .map((entry) =>
              {'dayOfWeek': entry.key.substring(0, 3), 'total': entry.value})
          .toList();
      notifyListeners();
    } catch (e) {
      log("Error in fetchWaterFootprintData() function${e.toString()}");
    }
  }

  String _getDayOfWeekString(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  Stream<QuerySnapshot> getStatsData(String uid) {
    var snapshot = firestore
        .collection('users')
        .doc(uid)
        .collection('waterfootprints')
        .snapshots();
    // notifyListeners();
    return snapshot;
  }

  // Stream<QuerySnapshot> getLastSevenDaysData(String uid) {
  //   var snapshot = firestore
  //       .collection("users")
  //       .doc(uid)
  //       .collection("waterfootprints")
  //       .snapshots();
  //   return snapshot;
  // }

  Future<String> uploadFileAndGetUrl(
    File file,
    String uid,
  ) async {
    try {
      List<int> imageBytes = await file.readAsBytes();
      img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

      img.Image resizedImage = img.copyResize(image, width: 500);
      List<int> compressByBytes = img.encodeJpg(resizedImage, quality: 50);

      File compressedFile = File(file.path);
      await compressedFile.writeAsBytes(compressByBytes);

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("waterfootprint/images/$uid/$fileName.jpg  ");
      await ref.putFile(compressedFile);
      String downloadUrl = await ref.getDownloadURL();
      print("File Uploaded successfuly. Download Url is $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error in uploadFileAndGetUrl() function: ${e.toString()}");
      return "";
    }
  }

  Future<void> getWaterFootprintData(
      File file, String product, String uid) async {
    var response = await http.get(Uri.parse(
        "https://aquaniti-default-rtdb.asia-southeast1.firebasedatabase.app/data.json"));
    // log(response.body);
    var data = jsonDecode(response.body) as List<dynamic>;
    for (int i = 0; i < data.length; i++) {
      if (data[i]['Product'] == product.toLowerCase()) {
        log("Waterfootprint data recieved ${WaterFootprint.fromMap(data[i]).toString()}");
        _waterFootprint = WaterFootprint.fromMap(data[i]);
        var downloadUrl = await uploadFileAndGetUrl(file, uid);
        var waterFootprintMap = _waterFootprint.toMap();
        waterFootprintMap['date'] = DateTime.now().millisecondsSinceEpoch;
        waterFootprintMap['imageUrl'] = downloadUrl;
        await firestore
            .collection("users")
            .doc(uid)
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

  Future<void> addWaterFootprintDataToStateAndCityCollections(
      String stateName,
      String cityName,
      double greenWaterFootprint,
      double greyWaterFootprint,
      double blueWaterFootprint) async {
    final docRef = await firestore
        .collection("states")
        .doc(stateName)
        .collection("cities")
        .doc(cityName);
    final cityData = (await docRef.get()).data();
    if (cityData == null) {
      await docRef.set({
        'cityName': cityName,
        'green_water_footprint': greenWaterFootprint,
        'blue_water_footprint': blueWaterFootprint,
        'grey_water_footprint': greyWaterFootprint,
        'total_water_footprint':
            greenWaterFootprint + blueWaterFootprint + greyWaterFootprint,
      });
    } else {
      docRef.update({
        "green_water_footprint": FieldValue.increment(greenWaterFootprint),
        "blue_water_footprint": FieldValue.increment(blueWaterFootprint),
        "grey_water_footprint": FieldValue.increment(greyWaterFootprint),
        "total_water_footprint": FieldValue.increment(
            greenWaterFootprint + blueWaterFootprint + greyWaterFootprint),
      });
    }
  }
}
