import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_authfb_demo/widgets/credit_card_payment.dart';
import 'package:flutter_authfb_demo/widgets/online_banking_payment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_authfb_demo/widgets/cash_payment.dart';

import '../widgets/custom_textfield.dart';

class PayMethodScreen extends StatefulWidget {
  const PayMethodScreen({super.key});

  @override
  State<PayMethodScreen> createState() => _PayMethodScreenState();
}

class _PayMethodScreenState extends State<PayMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Method"),
        backgroundColor: const Color.fromARGB(224, 15, 28, 70),
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const <Widget>[
            CashMethod(),
            CreditCardMethod(),
            OnlinePaymentMethod(),
          ],
        ),
      ),
    );
  }
}
