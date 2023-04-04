import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/checkbox.dart';
import 'package:flutter_authfb_demo/widgets/increment_decrement_form.dart';

class ProductCart extends StatefulWidget {
  const ProductCart(
      {super.key,
      required this.image,
      required this.productName,
      required this.productPrice});
  final String image;
  final String productName;
  final String productPrice;

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          const CustomCheckBox(),
          Expanded(
            child: Container(
              height: 110,
              color: Colors.yellow[200],
              child: Row(
                children: [
                  Image.asset(
                    widget.image,
                    fit: BoxFit.fitHeight,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.productPrice,
                        style: TextStyle(fontSize: 18),
                      ),
                      const InreDecrForm(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
