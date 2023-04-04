import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DropDown extends StatefulWidget {
  const DropDown({
    super.key,
    required this.dropdownTitle,
  });
  final String dropdownTitle;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final List<String> items = [
    'Shirt',
    'Short',
    'Shoes',
    'Equipment',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Container(
            child: Row(
              children: [
                const SizedBox(
                  width: 7,
                ),
                Text(
                  widget.dropdownTitle,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}
