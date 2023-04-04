import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductTile extends StatelessWidget {
  @override
  const ProductTile({super.key, required this.itemNo});

  final int itemNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      // child: StreamBuilder(stream: ,builder: ,),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/product1.jpeg"),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 5, top: 5),
                alignment: Alignment.topLeft,
                child: const Icon(Icons.favorite_border),
              ),
            ),
            Text(
              "Product $itemNo",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Price",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Sold 8.4k"),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.blue,
                      disabledForegroundColor: Colors.red.withOpacity(0.38),
                    ),
                    onPressed: null,
                    child: const Text('Add to cart'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
