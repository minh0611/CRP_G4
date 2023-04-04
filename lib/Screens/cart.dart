import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/cart_product.dart';
import 'package:flutter_authfb_demo/widgets/checkbox.dart';
import 'package:flutter_authfb_demo/widgets/increment_decrement_form.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen"),
        backgroundColor: const Color.fromARGB(224, 15, 28, 70),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: const [
                CustomCheckBox(),
                Text("Select all"),
              ],
            ),
            Expanded(
              child: ListView(
                children: const [
                  ProductCart(
                      image: "assets/productImages/product1.jpeg",
                      productName: "Air Force 1",
                      productPrice: "14"),
                  ProductCart(
                      image: "assets/productImages/product1.jpeg",
                      productName: "Air Force 1",
                      productPrice: "14"),
                  ProductCart(
                      image: "assets/productImages/product1.jpeg",
                      productName: "Air Force 1",
                      productPrice: "14"),
                  ProductCart(
                      image: "assets/productImages/product1.jpeg",
                      productName: "Air Force 1",
                      productPrice: "14"),
                  ProductCart(
                      image: "assets/productImages/product1.jpeg",
                      productName: "Air Force 1",
                      productPrice: "14"),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(224, 15, 28, 70),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(224, 15, 28, 70)),
                      child: const Text(
                        "Proceed Payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.delete_sweep_rounded,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
