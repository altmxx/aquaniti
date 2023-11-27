import 'package:aquaniti/models/waterFootprint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  List<WaterFootprint> _waterFootprints = [];

  List<WaterFootprint> get waterFootprints => _waterFootprints;

  final firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getLatestWaterFootprintsOfUser(
      String uid) {
    // firestore
    //     .collection("users")
    //     .doc(uid)
    //     .collection("waterfootprints")
    //     .orderBy("date", descending: true)
    //     .limit(5)
    //     .get()
    //     .then((querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     _waterFootprints.add(WaterFootprint.fromMap(doc.data()));
    //   });
    //   notifyListeners();
    // });
    var data = firestore
        .collection("users")
        .doc(uid)
        .collection("waterfootprints")
        .orderBy("date", descending: true)
        .limit(3)
        .snapshots();
    return data;
    // notifyListeners();
  }
}
