import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/newDetail.dart';
import 'package:flutter_authfb_demo/Screens/productDetail.dart';
import 'package:flutter_authfb_demo/models/new_model.dart';
import 'package:flutter_authfb_demo/widgets/banner_home.dart';
import 'package:flutter_authfb_demo/widgets/new_container.dart';

import '../models/product_model.dart';

class HomeBodyScreen extends StatefulWidget {
  const HomeBodyScreen({super.key});

  @override
  State<HomeBodyScreen> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  // final List<String> imgList = [
  //   'assets/images/banner.jpeg',
  //   'assets/images/banner2.jpeg',
  //   'assets/images/banner4.jpeg',
  // ];
  List<ProductModel> productList = [];
  List<ProductModel> bestProductList = [];
  List<NewModel> newList = [];
  List<NewModel> latestNewList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var data = await FirebaseFirestore.instance.collection('product').get();
    var data2 = await FirebaseFirestore.instance.collection('news').get();
    setState(() {
      productList = data.docs
          .map(
            (doc) => ProductModel.fromMap(doc.data()),
          )
          .toList();
      newList = data2.docs
          .map(
            (doc) => NewModel.fromMap(doc.data()),
          )
          .toList();
    });
    filterBestProduct();
    filterLatestNew();
    print(newList);
  }

  filterBestProduct() async {
    List<ProductModel> showFilter = [];
    for (var element in productList) {
      if (element.product_sales > 50) {
        showFilter.add(element);
      }
      setState(() {
        bestProductList.clear();
        bestProductList.addAll(showFilter);
        // print('result: $bestProductList');
      });
    }
    setState(() {
      bestProductList = showFilter;
    });
  }

  filterLatestNew() async {
    List<NewModel> showFilterNew = [];
    for (var element in newList) {
      var time = element.new_publish_date.toDate();
      if (time.isAfter(DateTime(2023, 3, 20, 0, 0))) {
        showFilterNew.add(element);
      }
      setState(() {
        latestNewList.clear();
        latestNewList.addAll(showFilterNew);
        print('time: $latestNewList');
      });
    }
    setState(() {
      latestNewList = showFilterNew;
      print(latestNewList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                const BannerHome(),
                const Center(
                  child: Text(
                    "Top Sales ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: size.height,
                  child: Expanded(
                    child: GridView.builder(
                        // scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bestProductList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.5),
                        itemBuilder: (BuildContext context, int index) =>
                            buildProductCard(context, index)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Text(
                    "Latest New ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                    height: size.height,
                    child: Expanded(
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, childAspectRatio: 2.5),
                          itemCount: latestNewList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildNewCard(context, index)),
                    ))
              ],
            )),
          ],
        ),
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
                        bestProductList[index].product_img,
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
                              productModel: bestProductList[index],
                            )));
              },
              child: Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    bestProductList[index].product_name,
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
                '\$ ${bestProductList[index].product_price}',
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
                    Text(
                        'In Stock: ${bestProductList[index].product_available}'),
                    Text('Sold: ${bestProductList[index].product_sales}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewDetailScreen(
                      newModel: latestNewList[index],
                    )));
      },
      child: NewContainer(
          image: latestNewList[index].new_img,
          newSummary: latestNewList[index].new_subtitle,
          newTitle: latestNewList[index].new_title),
    );
  }
}
