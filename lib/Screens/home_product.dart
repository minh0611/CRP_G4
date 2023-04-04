// ignore_for_file: prefer_collection_literals, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/productDetail.dart';
import 'package:flutter_authfb_demo/models/product_model.dart';
import 'package:flutter_authfb_demo/widgets/category_icon.dart';

class HomeProductScreen extends StatefulWidget {
  const HomeProductScreen({super.key});

  @override
  State<HomeProductScreen> createState() => _HomeProductScreenState();
}

class _HomeProductScreenState extends State<HomeProductScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  late Future reloadResult;
  List<ProductModel> productList = [];
  List<ProductModel> resultList = [];
  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(_onSearchChange);
    getProduct();
  }

  @override
  void dispose() {
    _searchTextController.removeListener(_onSearchChange);
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  void _didChangeDependencies() {
    super.didChangeDependencies();
    reloadResult = getProduct();
  }

  _onSearchChange() {
    searchResult();
    print(_searchTextController.text.trim());
  }

  filterShirt() {
    List<ProductModel> showFilter = [];
    for (var element in productList) {
      if (element.product_type == "Shirt") {
        showFilter.add(element);
        print(showFilter);
      }
      setState(() {
        resultList.clear();
        resultList.addAll(showFilter);
      });
    }
  }

  searchResult() {
    List<ProductModel> showResult = [];
    // ignore: unused_local_variable
    if (_searchTextController.text != "") {
      for (var element in productList) {
        if (element.product_name.contains(_searchTextController.text)) {
          showResult.add(element);
          print(showResult);
        }
      }
      setState(() {
        resultList.clear();
        resultList.addAll(showResult);
      });
    } else {
      showResult = List<ProductModel>.from(productList);
    }
    setState(() {
      resultList = showResult;
    });
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
    searchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: double.maxFinite,
              height: 130,
              child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.2,
                  ),
                  children: const [
                    CategoryIcon(
                        iconImage: 'assets/icon_images/shirt.png',
                        categoryName: "Shirt"),
                    CategoryIcon(
                        iconImage: 'assets/icon_images/short.png',
                        categoryName: "Short"),
                    CategoryIcon(
                        iconImage: 'assets/icon_images/shoes.png',
                        categoryName: "Shoe"),
                    CategoryIcon(
                        iconImage: 'assets/icon_images/equipment.png',
                        categoryName: "Equipment"),
                  ]),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _searchTextController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              hintText: 'What is in your mind?',
            ),
            onChanged: (value) {
              _onSearchChange();
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: GridView.builder(
              itemCount: resultList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.55),
              itemBuilder: (BuildContext context, int index) =>
                  buildProductCard(context, index)),
        ),
      ]),
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
                        resultList[index].product_img,
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
                              productModel: resultList[index],
                            )));
              },
              child: Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    resultList[index].product_name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
                '\$ ${resultList[index].product_price}',
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
                    Text('Sold: ${resultList[index].product_sales}'),
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

//       GridView.builder(
//     itemCount: 100,
//     itemBuilder: (context, index) => ProductTile(
//       itemNo: index,
//     ),
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       childAspectRatio: 0.65,
//     ),
//   )),
// ]),
