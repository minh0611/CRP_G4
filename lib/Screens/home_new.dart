import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/home_personal.dart';
import 'package:flutter_authfb_demo/Screens/newDetail.dart';
import 'package:flutter_authfb_demo/models/new_model.dart';
import 'package:flutter_authfb_demo/widgets/category_icon.dart';
import 'package:flutter_authfb_demo/widgets/new_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeNewScreen extends StatefulWidget {
  const HomeNewScreen({super.key});

  @override
  State<HomeNewScreen> createState() => _HomeNewScreenState();
}

class _HomeNewScreenState extends State<HomeNewScreen> {
  List<NewModel> newList = [];
  @override
  void initState() {
    super.initState();
    getNew();
  }

  getNew() async {
    var data = await FirebaseFirestore.instance.collection('news').get();
    setState(() {
      newList = data.docs
          .map(
            (doc) => NewModel.fromMap(doc.data()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Daily New",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.blueGrey, width: 1))),
              // color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 130,
                child: GridView(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.2,
                    ),
                    children: const [
                      CategoryIcon(
                          iconImage: 'assets/icon_images/flash_sales.png',
                          categoryName: "Flash Sales"),
                      CategoryIcon(
                          iconImage: 'assets/icon_images/newArrive.png',
                          categoryName: "New Arrives"),
                      CategoryIcon(
                          iconImage: 'assets/icon_images/bestProduct.png',
                          categoryName: "Best Product"),
                      CategoryIcon(
                          iconImage: 'assets/icon_images/sale.png',
                          categoryName: "Monthly Sales"),
                    ]),
              )),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "All News",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 2.5),
                  itemCount: newList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildNewCard(context, index)))
        ],
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
                      newModel: newList[index],
                    )));
      },
      child: NewContainer(
          image: newList[index].new_img,
          newSummary: newList[index].new_subtitle,
          newTitle: newList[index].new_title),
    );
  }
}
