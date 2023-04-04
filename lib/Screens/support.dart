import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/widgets/aboutUsExpandable.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
            children: const [
              Center(
                  child: Text(
                "Common questions",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 15,
              ),
              AboutUsExpandable(
                  infoTitle: "Question 1",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 1"),
              SizedBox(
                height: 15,
              ),
              AboutUsExpandable(
                  infoTitle: "Question 2",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 2"),
              SizedBox(
                height: 15,
              ),
              AboutUsExpandable(
                  infoTitle: "Question 3",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 3"),
              SizedBox(
                height: 15,
              ),
              AboutUsExpandable(
                  infoTitle: "Question 4",
                  infoIcon: Icons.question_mark_rounded,
                  infoContent: "Answer 4"),
            ],
          ),
        ));
  }
}
