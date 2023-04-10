import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/models/cart_model.dart';
import 'package:flutter_authfb_demo/widgets/checkbox.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({super.key});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  List<CartModel> cartList = [];

  @override
  void initState() {
    super.initState();
    getCart();
  }

  getCart() async {
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
    print('list: $cartList');
  }

  List<Widget> renderCard() {
    List<Widget> newList = [];
    for (var element in cartList) {
      Widget items = Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Image.network(
                element.image,
                fit: BoxFit.contain,
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    element.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text("Size: ${element.size}",
                      style: const TextStyle(fontSize: 15)),
                  Text(
                    "\$ ${element.price}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Amount added: ${element.amountProduct}"),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.delete_sweep_rounded,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      newList.add(items);
    }

    return newList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: renderCard(),
      ),
    );
  }
}
