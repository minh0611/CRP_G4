import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final int amountProduct;
  final String image;
  final String name;
  final int price;
  final String size;
  final int totalPrice;

  CartModel(
      {required this.amountProduct,
      required this.image,
      required this.name,
      required this.price,
      required this.size,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'amountProduct': amountProduct});
    result.addAll({'image': image});
    result.addAll({'name': name});
    result.addAll({'price': price});
    result.addAll({'size': size});
    result.addAll({'totalPrice': totalPrice});

    return result;
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
        amountProduct: map['amountProduct'] ?? '',
        image: map['image'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        size: map['size'] ?? '',
        totalPrice: map['totalPrice'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));
}
