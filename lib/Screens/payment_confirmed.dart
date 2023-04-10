import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/orderStatus.dart';
import 'package:flutter_authfb_demo/Screens/pay_method.dart';
import 'package:flutter_authfb_demo/models/cart_model.dart';
import 'package:flutter_authfb_demo/widgets/cart_product.dart';
import 'package:email_otp/email_otp.dart';

class PaymentConfirmedScreen extends StatefulWidget {
  const PaymentConfirmedScreen({super.key});

  @override
  State<PaymentConfirmedScreen> createState() => _PaymentConfirmedScreenState();
}

class _PaymentConfirmedScreenState extends State<PaymentConfirmedScreen> {
  int currentStep = 0;
  late String uEmail = '';
  late String uPaymentMethod = '';
  EmailOTP myauth = EmailOTP();
  List<CartModel> cartList = [];
  double totalBill = 0;

  var date = DateTime.now();
  TextEditingController otp = TextEditingController();

  deleteItemCart() {
    print("delete items");
  }

  getCartList() async {
    var data = await FirebaseFirestore.instance
        .collection('users-cart-item')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    setState(() {
      cartList = data.docs
          .map(
            (doc) => CartModel.fromMap(doc.data()),
          )
          .toList();
    });
    getTotalPrice();
  }

  getTotalPrice() {
    double newBill = 0;
    cartList.forEach((element) {
      newBill += element.totalPrice;
    });
    // print('total: $newBill');
    setState(() {
      totalBill = newBill;
    });
    print(totalBill);
  }

  Future addOrderCart() async {
    var deliveryDate = DateTime(date.day + 3, date.month, date.year);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("order");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      'deliveryTime': deliveryDate,
      'totalPrice': totalBill,
      'status': 'WAITING FOR CONFIRM'
    }).then((value) => print("Add Order Successfully"));
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Confirmed"),
        backgroundColor: const Color.fromARGB(224, 15, 28, 70),
      ),
      body: Container(
          child: Stepper(
        // type: StepperType.horizontal,
        currentStep: currentStep,
        onStepCancel: () => currentStep == 0
            ? null
            : setState(() {
                currentStep -= 1;
              }),
        onStepContinue: () async {
          bool isLastStep = (currentStep == getSteps().length - 1);
          if (isLastStep) {
            addOrderCart();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const OrderStatus();
              },
            ));
          } else if (currentStep == getSteps().length - 3) {
            if (await myauth.verifyOTP(otp: otp.text) == true) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("OTP is verified"),
              ));
              setState(() {
                currentStep += 1;
                print(totalBill);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Invalid OTP"),
              ));
              currentStep = currentStep;
            }
            print("step 1");
          } else {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepTapped: (step) => setState(() {
          currentStep = step;
        }),
        steps: getSteps(),
      )),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Confirm Personal Info"),
        content: Column(
          children: [
            FutureBuilder(
                future: _fetch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return (const Text("Loading... Please wait"));
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            uEmail,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () async {
                                myauth.setConfig(
                                    appEmail: "me@rohitchouhan.com",
                                    appName: "Email OTP",
                                    userEmail: uEmail,
                                    otpLength: 6,
                                    otpType: OTPType.digitsOnly);
                                if (await myauth.sendOTP() == true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("OTP has been sent"),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Oops, OTP send failed"),
                                  ));
                                }
                              },
                              child: const Text("Send OTP")),
                        ],
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.only(left: 18),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: TextFormField(
                  controller: otp,
                  decoration: const InputDecoration(hintText: 'Enter Otp'),
                )),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Confirm Payment Method"),
        content: Column(
          children: [
            FutureBuilder(
                future: _fetch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return (const Text("Loading... Please wait"));
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Payment Method chosen: "),
                          Text(
                            uPaymentMethod,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PayMethodScreen())),
                child: const Text(
                  'Add Payment Method',
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Submit Order"),
        content: Column(
          children: [
            const Text(
              'Product in cart',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const ProductCart(),
            )
          ],
        ),
      ),
    ];
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance.collection('users').get().then((ds) {
        ds.docs.forEach((result) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .collection('payment_method')
              .get()
              .then((subCol) {
            subCol.docs.forEach((element) {
              uPaymentMethod = element.data()['type'];
              print(uPaymentMethod);
            });
          });
        });
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        uEmail = ds.data()!['email'];
      });
    }
  }
}
