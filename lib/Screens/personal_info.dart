import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/profile_container.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late String uFullname = '';
  late String uEmail = '';
  late String uAge = '';
  late String uAddress = '';
  late String uPhoneNumber = '';
  late String uPaymentMethod = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
        backgroundColor: const Color.fromARGB(224, 15, 28, 70),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: const CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person_2_outlined,
                  size: 50,
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return (const Text("Loading... Please wait"));
                } else {
                  return Column(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 25),
                          child: Text(
                            " $uFullname",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      PersonalProfileContainer(
                          subHeader: "Email: ", userInfo: uEmail),
                      PersonalProfileContainer(
                          subHeader: "Age: ", userInfo: uAge),
                      PersonalProfileContainer(
                          subHeader: "Phone: ", userInfo: uPhoneNumber),
                      PersonalProfileContainer(
                          subHeader: "Address: ", userInfo: uAddress),
                      PersonalProfileContainer(
                          subHeader: "Payment Method: ",
                          userInfo: uPaymentMethod),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance.collection('users').get().then((ds) {
        ds.docs.forEach((result) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .collection('payment_method')
              .get()
              .then((subCol) {
            subCol.docs.forEach((element) {
              uPaymentMethod = element.data()['type'];
              print(uPaymentMethod);
            });
          });
        });
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        uFullname = ds.data()!['fullname'];
        uAge = ds.data()!['age'];
        uEmail = ds.data()!['email'];
        uAddress = ds.data()!['address'];
        uPhoneNumber = ds.data()!['phoneNumber'];
      });
    }
  }
}
