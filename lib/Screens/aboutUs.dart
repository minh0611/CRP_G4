import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/aboutUsExpandable.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final Stream<QuerySnapshot> _aboutUsStream =
      FirebaseFirestore.instance.collection('aboutUs').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About Us"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(224, 15, 28, 70),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _aboutUsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];
                    return Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AboutUsExpandable(
                              infoTitle: _documentSnapshot['au_title'],
                              infoIcon: Icons.question_mark,
                              infoContent: _documentSnapshot['au_content']),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
