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
    var url = Uri.parse("tel://0862179527");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
              const AboutUsExpandable(
                  infoTitle: "Question 1",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 1"),
              const SizedBox(
                height: 15,
              ),
              const AboutUsExpandable(
                  infoTitle: "Question 2",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 2"),
              const SizedBox(
                height: 15,
              ),
              const AboutUsExpandable(
                  infoTitle: "Question 3",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 3"),
              const SizedBox(
                height: 15,
              ),
              const AboutUsExpandable(
                  infoTitle: "Question 4",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 4"),
              InkWell(
                onTap: () => _launchCaller(),
                child: const CategoryIcon(
                    iconImage: 'assets/icon_images/shirt.png',
                    categoryName: "Call Support"),
              ),
            ],
          ),
        ));
  }
}
