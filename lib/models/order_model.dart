import 'dart:convert';

class OrderModel {
  final DateTime deliveryTime;

  final int totalPrice;

  final String reciever;

  OrderModel(
      {required this.deliveryTime,
      required this.totalPrice,
      required this.reciever});
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'deliveryTime': deliveryTime});
    result.addAll({'totalPrice': totalPrice});
    result.addAll({'reciever': reciever});
    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      deliveryTime: map['deliveryTime'] ?? '',
      totalPrice: map['totalPrice'] ?? '',
      reciever: map['reciever'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
