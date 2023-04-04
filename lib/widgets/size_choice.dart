import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/utils/color_utils.dart';

class SizeChoiceContainer extends StatefulWidget {
  const SizeChoiceContainer({super.key, required this.size});
  final String size;

  @override
  State<SizeChoiceContainer> createState() => _SizeChoiceContainerState();
}

class _SizeChoiceContainerState extends State<SizeChoiceContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        gradient: LinearGradient(colors: [
          hexStringColor("ffffff"),
          hexStringColor("7478d1"),
          hexStringColor("7478d1"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Center(
        child: Text(
          widget.size,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
