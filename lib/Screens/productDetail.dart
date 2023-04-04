import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/models/product_model.dart';
import 'package:flutter_authfb_demo/utils/color_utils.dart';
import 'package:flutter_authfb_demo/widgets/increment_decrement_form.dart';
import 'package:flutter_authfb_demo/widgets/size_choice.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;
  Future addProductCart() async {}
  Future addProductFavourite() async {}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(425),
          child: Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: size.height / 2,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black, width: 1),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                  productModel.product_img,
                ),
              ),
            ),
            child: Container(
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
                  const InkWell(
                    onTap: null,
                    child: Icon(
                      Icons.favorite_outline,
                      size: 30,
                    ),
                  )
                ],
              ),
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
                    Text(
                      productModel.product_name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$ ${productModel.product_price}',
                      style: TextStyle(
                          color: hexStringColor("8776ff"),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
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
                Row(
                  children: const [
                    SizeChoiceContainer(size: "S"),
                    SizeChoiceContainer(size: "M"),
                    SizeChoiceContainer(size: "L"),
                    SizeChoiceContainer(size: "XL"),
                  ],
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
                  productModel.product_des,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                hexStringColor("ffffff"),
                                hexStringColor("7478d1"),
                                hexStringColor("7478d1"),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: const InreDecrForm()),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Add to Cart'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
