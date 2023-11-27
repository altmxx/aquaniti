import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarketPlaceItem {
  String id;
  String name;
  String bName;
  String description;
  int price;
  double waterFootprint;
  MarketPlaceItem({
    required this.id,
    required this.name,
    required this.bName,
    required this.description,
    required this.price,
    required this.waterFootprint,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bName': bName,
      'description': description,
      'price': price,
      'waterFootprint': waterFootprint,
    };
  }

  factory MarketPlaceItem.fromMap(Map<String, dynamic> map) {
    return MarketPlaceItem(
      id: map['id'] as String,
      name: map['name'] as String,
      bName: map['bName'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      waterFootprint: map['waterFootprint'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketPlaceItem.fromJson(String source) => MarketPlaceItem.fromMap(json.decode(source) as Map<String, dynamic>);
}