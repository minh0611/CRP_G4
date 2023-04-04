import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/productDetail.dart';

import '../models/product_model.dart';

final List<String> imgList = [
  'assets/images/banner.jpeg',
  'assets/images/banner2.jpeg',
  'assets/images/banner4.jpeg',
];

class HomeBodyScreen extends StatefulWidget {
  const HomeBodyScreen({super.key});

  @override
  State<HomeBodyScreen> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  List<ProductModel> productList = [];
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  getProduct() async {
    var data = await FirebaseFirestore.instance.collection('product').get();
    setState(() {
      productList = data.docs
          .map(
            (doc) => ProductModel.fromMap(doc.data()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CarouselSlider(
            items: imgList
                .map((item) => Container(
                      child: Center(
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 5),
            ),
          ),
          const Text(
            "Top Sales ",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
                itemCount: productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.55),
                itemBuilder: (BuildContext context, int index) =>
                    buildProductCard(context, index)),
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        productList[index].product_img,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    alignment: Alignment.topLeft,
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                              productModel: productList[index],
                            )));
              },
              child: Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    productList[index].product_name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 1,
              child: Text(
                '\$ ${productList[index].product_price}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.blue,
                        disabledForegroundColor: Colors.red.withOpacity(0.38),
                      ),
                      onPressed: null,
                      child: const Text('Add to cart'),
                    ),
                    Text('Sold: ${productList[index].product_sales}'),
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