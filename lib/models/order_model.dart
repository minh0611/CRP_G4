import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final Timestamp deliveryTime;

  final double totalPrice;

  final String status;

  OrderModel(
      {required this.deliveryTime,
      required this.totalPrice,
      required this.status});
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'deliveryTime': deliveryTime});
    result.addAll({'totalPrice': totalPrice});
    result.addAll({'status': status});
    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      deliveryTime: map['deliveryTime'] ?? '',
      totalPrice: map['totalPrice'] ?? '',
      status: map['status'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
