import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/aboutUsExpandable.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(224, 15, 28, 70),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            AboutUsExpandable(
                infoTitle: "Who are we",
                infoIcon: Icons.question_mark,
                infoContent:
                    "We are LMSD fashion company. This is a new brand established in early 2022 in Vietnam. We manufacture products for sports player from semi-professional to professional"),
            SizedBox(
              height: 20,
            ),
            AboutUsExpandable(
                infoTitle: "About our product/services",
                infoIcon: Icons.question_mark,
                infoContent:
                    "We bring you the best and most premium quality products. Suitable for all ages and genders. Besides, we provide you with sevices such as return and refund, change the size when it is not suitable, answer questions quickly, convenient payment"),
            SizedBox(
              height: 20,
            ),
            AboutUsExpandable(
                infoTitle: "How to contact us",
                infoIcon: Icons.question_mark,
                infoContent:
                    "Address Hanoi HUB: BTEC FPT Building, Trinh Van Bo Ward, Xuan Phuong, Hanoi 123342.\n\n Hotline: 0984400xx \n\n Email: lmsdsport@gmail.com"),
          ],
        ),
      ),
    );
  }
}
