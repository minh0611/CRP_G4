import 'package:flutter/material.dart';

class CustomerButton extends StatefulWidget {
  const CustomerButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.subIcon});
  final Function onTap;
  final String title;
  final IconData subIcon;

  @override
  State<CustomerButton> createState() => _CustomerButtonState();
}

class _CustomerButtonState extends State<CustomerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: 80,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Icon(widget.subIcon)
        ]),
      ),
    );
  }
}
