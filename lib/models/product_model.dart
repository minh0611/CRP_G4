import 'dart:convert';

class ProductModel {
  final String product_brand;

  final String product_img;

  final String product_name;

  final int product_price;

  final String product_des;

  final int product_sales;

  final String product_type;

  final String product_gender;

  ProductModel({
    required this.product_brand,
    required this.product_img,
    required this.product_name,
    required this.product_price,
    required this.product_des,
    required this.product_sales,
    required this.product_type,
    required this.product_gender,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'product_brand': product_brand});
    result.addAll({'product_img': product_img});
    result.addAll({'product_name': product_name});
    result.addAll({'product_price': product_price});
    result.addAll({'product_des': product_des});
    result.addAll({'product_sales': product_sales});
    result.addAll({'product_sales': product_type});
    result.addAll({'product_gender': product_gender});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      product_brand: map['product_brand'] ?? '',
      product_des: map['product_des'] ?? '',
      product_img: map['product_img'] ?? '',
      product_name: map['product_name'] ?? '',
      product_price: map['product_price'] ?? '',
      product_sales: map['product_sales'] ?? '',
      product_type: map['product_type'] ?? '',
      product_gender: map['product_gender'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
