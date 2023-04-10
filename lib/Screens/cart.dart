import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/payment_confirmed.dart';
import 'package:flutter_authfb_demo/models/cart_model.dart';
import 'package:flutter_authfb_demo/widgets/cart_product.dart';
import 'package:flutter_authfb_demo/widgets/checkbox.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartModel> cartList = [];
  double totalBill = 0;

  getCartList() async {
    var data = await FirebaseFirestore.instance
        .collection('users-cart-item')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    setState(() {
      cartList = data.docs
          .map(
            (doc) => CartModel.fromMap(doc.data()),
          )
          .toList();
    });
    getTotalPrice();
  }

  getTotalPrice() {
    double newBill = 0;
    cartList.forEach((element) {
      newBill += element.totalPrice;
    });
    print('total: $newBill');
    setState(() {
      totalBill = newBill;
    });
    // return totalCartBill;
  }

  deleteCartItem() {
    print("delete item");
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

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
            const Expanded(child: ProductCart()),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Total Price: \$ ${totalBill.toString()} ",
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 60,
              child: InkWell(
                // onTap: () => getCartList(),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentConfirmedScreen())),
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
