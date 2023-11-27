import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/marketplace_item.dart';

class MarketplaceProvider extends ChangeNotifier {
  List<MarketPlaceItem> _marketPlaceItems = [];

  List<MarketPlaceItem> get marketPlaceItems => _marketPlaceItems;

  final firestore = FirebaseFirestore.instance;

  void fetchAndSetMarketplaceProducts() async {
    var querySnap = await firestore.collection("marketplace").get();
    querySnap.docs.forEach((doc) {
      print(doc.data());
      Map<String, dynamic> data = doc.data();
      data["id"] = doc.id;
      _marketPlaceItems.add(MarketPlaceItem.fromMap(data));
    });
    notifyListeners();
  }
}
