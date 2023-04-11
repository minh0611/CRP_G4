import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/home.dart';
import 'package:flutter_authfb_demo/models/order_model.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  List<OrderModel> orderList = [];
  @override
  void initState() {
    super.initState();
    getOrder();
  }

  var currentUser = FirebaseAuth.instance.currentUser!.email;

  getOrder() async {
    var data = await FirebaseFirestore.instance
        .collection('order')
        .doc(currentUser)
        .collection('items')
        .get();
    setState(() {
      orderList = data.docs
          .map(
            (e) => OrderModel.fromMap(e.data()),
          )
          .toList();
    });
    print('list: $orderList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: const Color.fromARGB(224, 15, 28, 70),
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              Builder(
                builder: (context) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(
                width: 120,
              ),
              const Text(
                "Orders",
                style: TextStyle(fontSize: 23, color: Colors.white),
              ),
            ]),
          )),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Expanded(
          child: Column(
            children: [
              const Text(
                "Order Submitted",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 600,
                child: Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, childAspectRatio: 2.5),
                        itemCount: orderList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildOrderCard(context, index))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderCard(BuildContext context, int index) {
    return SingleChildScrollView(
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order By: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  currentUser.toString(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Expected Delivery Date: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text('${orderList[index].deliveryTime.toDate()}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Price of the order: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  '\$ ${orderList[index].totalPrice}',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order Status: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(orderList[index].status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
