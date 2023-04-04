import 'package:flutter/material.dart';

class CategoryIcon extends StatefulWidget {
  const CategoryIcon(
      {super.key, required this.iconImage, required this.categoryName});
  final String iconImage;
  final String categoryName;

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 2, color: Colors.black),
              ),
              child: Image.asset(
                widget.iconImage,
                width: 30,
                height: 30,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.categoryName,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
