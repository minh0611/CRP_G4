import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/orderStatus.dart';
import 'package:flutter_authfb_demo/Screens/pay_method.dart';
import 'package:flutter_authfb_demo/Screens/personal_info.dart';
import 'package:flutter_authfb_demo/Screens/support.dart';

import '../widgets/custom_button.dart';

class HomePersonalScreen extends StatefulWidget {
  const HomePersonalScreen({super.key});

  @override
  State<HomePersonalScreen> createState() => _HomePersonalScreenState();
}

class _HomePersonalScreenState extends State<HomePersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomerButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const PersonalInfoScreen();
                },
              ));
            },
            title: "Personal Information",
            subIcon: Icons.person_rounded),
        CustomerButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const PayMethodScreen();
                },
              ));
            },
            title: "Payment Method",
            subIcon: Icons.payment_rounded),
        CustomerButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const OrderStatus();
                },
              ));
            },
            title: "Order",
            subIcon: Icons.fire_truck),
        CustomerButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SupportScreen();
                },
              ));
            },
            title: "Support Center",
            subIcon: Icons.headset_mic),
      ],
    );
  }
}
