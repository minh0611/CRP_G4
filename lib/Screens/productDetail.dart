import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/models/product_model.dart';
import 'package:flutter_authfb_demo/utils/color_utils.dart';
import 'package:flutter_authfb_demo/widgets/increment_decrement_form.dart';
import 'package:flutter_authfb_demo/widgets/size_choice.dart';

class Data {
  String label;

  Data(this.label);
}

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future addProductCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-item");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.productModel.product_name,
      "price": widget.productModel.product_price,
      "image": widget.productModel.product_img,
      "size": _choiceChipsList[_selectedIndex].label,
      "amountProduct": dropdownvalue.toInt(),
      "totalPrice": widget.productModel.product_price * dropdownvalue.toInt(),
    }).then((value) => print("Add To Cart Successfully"));
  }

  Future addProductFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-item");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.productModel.product_name,
      "price": widget.productModel.product_price,
      "image": widget.productModel.product_img,
    }).then((value) => print("Add To Favourite Successfully"));
  }

  late int _selectedIndex;
  final List<Data> _choiceChipsList = [
    Data("S"),
    Data("M"),
    Data("L"),
    Data("XL"),
  ];
  int dropdownvalue = 1;

  var items = [
    1,
    2,
    3,
    4,
  ];
  int? newValue;
  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(425),
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 20, 15),
            width: MediaQuery.of(context).size.width,
            height: size.height / 2,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black, width: 1),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                  widget.productModel.product_img,
                ),
              ),
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users-favourite-item')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('items')
                  .where("name", isEqualTo: widget.productModel.product_name)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  return Text("");
                }
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () => snapshot.data?.docs.length == 0
                            ? addProductFavourite()
                            : print("Already Added"),
                        child: snapshot.data?.docs.length == 0
                            ? const Icon(
                                Icons.favorite_outline,
                                size: 30,
                              )
                            : const Icon(Icons.favorite, size: 30),
                      )
                    ],
                  ),
                );
              },
            ),
          )),
      bottomSheet: Container(
        height: size.height / 2,
        width: size.width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(224, 15, 28, 70),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 5,
                    width: 32 * 1.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              hexStringColor("0F1C46"),
                              hexStringColor("0F1C46"),
                              hexStringColor("FFFFFF"),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        widget.productModel.product_name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        '\$ ${widget.productModel.product_price}',
                        style: TextStyle(
                            color: hexStringColor("8776ff"),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Size",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Wrap(
                  spacing: 6,
                  direction: Axis.horizontal,
                  children: choiceChips(),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Product Type",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.productModel.product_type,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Product Description",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.productModel.product_des,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Product Available",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '${widget.productModel.product_available} left in stock',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Amount product",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        DropdownButton(
                          dropdownColor: const Color.fromARGB(224, 15, 28, 70),
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((int items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                '$items',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              print(dropdownvalue);
                            });
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => addProductCart(),
                        child: const Text('Add to Cart'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          backgroundColor: Colors.blue,
          label: Text(_choiceChipsList[i].label),
          labelStyle: const TextStyle(color: Colors.white),
          selected: _selectedIndex == i,
          selectedColor: Colors.black,
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
      print(_choiceChipsList[_selectedIndex].label);
    }
    return chips;
  }
}
