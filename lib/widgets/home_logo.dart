import 'package:flutter/material.dart';

class HomeLogo extends StatefulWidget {
  const HomeLogo({super.key, required this.imageName});
  final String imageName;

  @override
  State<HomeLogo> createState() => _HomeLogoState();
}

class _HomeLogoState extends State<HomeLogo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.imageName,
      fit: BoxFit.fitWidth,
      width: 260,
      height: 260,
      alignment: Alignment.topCenter,
    );
  }
}
