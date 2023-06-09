import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/aboutUsExpandable.dart';
import 'package:flutter_authfb_demo/widgets/category_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  _launchCaller() async {
    const url = "tel:0862179527";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Stream<QuerySnapshot> _supportStream =
      FirebaseFirestore.instance.collection('support').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Support Center"),
          backgroundColor: const Color.fromARGB(224, 15, 28, 70),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Center(
                  child: Text(
                "Common questions",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _supportStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot _documentSnapshot =
                              snapshot.data!.docs[index];
                          return Column(
                            children: [
                              AboutUsExpandable(
                                  infoTitle: _documentSnapshot['sp_title'],
                                  infoIcon: Icons.question_mark_rounded,
                                  infoContent: _documentSnapshot['sp_content']
                                      .toString()
                                      .replaceAll("\\n", "\n")),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        });
                  }),
              InkWell(
                // ignore: deprecated_member_use
                onTap: () => _launchCaller(),
                child: const CategoryIcon(
                    iconImage: 'assets/icon_images/phoneIcon.png',
                    categoryName: "Call Support"),
              ),
            ],
          ),
        ));
  }
}
