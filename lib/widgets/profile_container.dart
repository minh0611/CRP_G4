import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalProfileContainer extends StatefulWidget {
  const PersonalProfileContainer(
      {super.key, required this.subHeader, required this.userInfo});
  final String subHeader;
  final String userInfo;

  @override
  State<PersonalProfileContainer> createState() =>
      _PersonalProfileContainerState();
}

class _PersonalProfileContainerState extends State<PersonalProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Container(
              width: 80,
              child: Text(
                widget.subHeader,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            SizedBox(
              width: 240,
              child: Text(
                widget.userInfo,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            // const SizedBox(
            //   width: 15,
            // ),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 5),
            //   // ignore: deprecated_member_use
            //   child: const FaIcon(FontAwesomeIcons.edit),
            // ),
          ],
        ),
      ),
    );
  }
}
