import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WaterFootprint {
  String id;
  String category;
  String product;
  DateTime? date;
  String? imageUrl;
  double blueWaterFootprint;
  double greyWaterFootprint;
  double greenWaterFootprint;
  double totalWaterFootprint;
  WaterFootprint({
    required this.id,
    required this.category,
    required this.product,
    this.date,
    this.imageUrl,
    required this.blueWaterFootprint,
    required this.greyWaterFootprint,
    required this.greenWaterFootprint,
    required this.totalWaterFootprint,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Category': category,
      'Product': product,
      "date": date,
      "imageUrl": imageUrl,
      'blue_water_footprint': blueWaterFootprint,
      'grey_water_footprint': greyWaterFootprint,
      'green_water_footprint': greenWaterFootprint,
      'total_water_footprint': totalWaterFootprint,
    };
  }

  factory WaterFootprint.fromMap(Map<String, dynamic> map) {
    return WaterFootprint(
      id: map['id'] as String,
      category: map['Category'] as String,
      product: map['Product'] as String,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      blueWaterFootprint: map['blue_water_footprint'] as double,
      greyWaterFootprint: map['grey_water_footprint'] as double,
      greenWaterFootprint: map['green_water_footprint'] as double,
      totalWaterFootprint: map['total_water_footprint'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory WaterFootprint.fromJson(String source) =>
      WaterFootprint.fromMap(json.decode(source) as Map<String, dynamic>);
}
