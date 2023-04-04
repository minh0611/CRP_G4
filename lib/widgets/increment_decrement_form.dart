import 'package:flutter/material.dart';
import 'package:increment_decrement_form_field/increment_decrement_form_field.dart';

class InreDecrForm extends StatefulWidget {
  const InreDecrForm({super.key});

  @override
  State<InreDecrForm> createState() => _InreDecrFormState();
}

class _InreDecrFormState extends State<InreDecrForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  int holder = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          /*
                  increment, decrement an int
                */
          IncrementDecrementFormField<int>(
            // an initial value
            initialValue: 0,

            // return the widget you wish to hold the value, in this case Text
            // if no value set 0, otherwise display the value as a string
            displayBuilder: (value, field) {
              return Text(
                value == null ? "0" : value.toString(),
              );
            },

            // run when the left button is pressed (decrement)
            // the current value is passed as a parameter
            // return what you want to update the display value to
            // when decrement is pressed. In this case if null 0,
            // otherwise current value -1
            onDecrement: (currentValue) {
              if (currentValue! >= 1) {
                return currentValue! - 1;
              }
              return currentValue!;
            },

            // run when the right button is pressed (increment)
            // the current value is passed as a parameter
            // return what you want to update the display value to
            // when increment is pressed. In this case if null 0,
            // otherwise current value +1
            onIncrement: (currentValue) {
              return currentValue! + 1;
            },
          ),
        ],
      ),
    );
  }
}
