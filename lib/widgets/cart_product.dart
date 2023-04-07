import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/checkbox.dart';
import 'package:flutter_authfb_demo/widgets/increment_decrement_form.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({
    super.key,
  });

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users-cart-item")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("items")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something is wrong... Please wait a moment"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
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
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                child: Image.network(
                                  _documentSnapshot['image'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      _documentSnapshot['name'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$ ${_documentSnapshot['price']}",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const InreDecrForm(),
                                        InkWell(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("users-cart-item")
                                                .doc(FirebaseAuth.instance
                                                    .currentUser?.email)
                                                .collection('items')
                                                .doc(_documentSnapshot.id)
                                                .delete();
                                          },
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
