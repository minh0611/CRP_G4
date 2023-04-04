import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/cart_product.dart';
import 'package:flutter_authfb_demo/widgets/checkbox.dart';
import 'package:flutter_authfb_demo/widgets/increment_decrement_form.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Screen"),
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
                        "Add to cart",
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
