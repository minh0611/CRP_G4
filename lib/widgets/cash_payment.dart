import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_authfb_demo/Screens/home_personal.dart';
import 'package:flutter_authfb_demo/Screens/personal_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/custom_textfield.dart';

class CashMethod extends StatefulWidget {
  const CashMethod({super.key});

  @override
  State<CashMethod> createState() => _CashMethodState();
}

class _CashMethodState extends State<CashMethod> {
  Future addCashPaymentMethod(String currency) async {
    var firebaseAuth = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.uid)
        .collection('payment_method')
        .doc()
        .set({'type': 'cash', 'currency': currency});
  }

  final TextEditingController _currencyTextController = TextEditingController();
  Future submitPayMethod() async {
    try {
      await addCashPaymentMethod(_currencyTextController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          backgroundColor: Color.fromARGB(224, 15, 28, 70),
          title: Text('Add payment method successfully',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Text('You have add cash as a payment method',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.moneyBill),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Cash",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )),
                collapsed: const Text(""),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(1))
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text("Enter the currency: "),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(20)),
                                height: 50,
                                child: AuthTextField(
                                    text: "Enter type of currency....",
                                    icon: Icons.person_outline,
                                    controller: _currencyTextController,
                                    isPasswordType: false),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: () => submitPayMethod(),
                                child: const Text("Add payment method"))
                          ],
                        ),
                      ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
