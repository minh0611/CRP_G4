import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_authfb_demo/Screens/home.dart';
import 'package:flutter_authfb_demo/widgets/auth_submit_button.dart';
import '../utils/color_utils.dart';
import '../widgets/custom_textfield.dart';
import 'signin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Future addUserDetail(String fullname, String age, String email,
      String address, String phoneNumber) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set({
      'fullname': fullname,
      'age': age,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber
    });
  }

  final TextEditingController _fullnameTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      addUserDetail(
        _fullnameTextController.text.trim(),
        _ageTextController.text.trim(),
        _emailTextController.text.trim(),
        _addressTextController.text.trim(),
        _phoneNumberTextController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color.fromARGB(224, 15, 28, 70),
          title: const Text('Sign Up Successfully',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: const Text('Please ok to log in again',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen())),
              child: const Text('OK',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(224, 15, 28, 70),
            content: Text(e.message.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringColor("0F1C46"),
              hexStringColor("0F1C46"),
              hexStringColor("FFFFFF"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 50,
                      child: AuthTextField(
                          text: "Enter Full name",
                          icon: Icons.person_outline,
                          controller: _fullnameTextController,
                          isPasswordType: false),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 50,
                      child: AuthTextField(
                          text: "Enter Age",
                          icon: Icons.person_outline,
                          controller: _ageTextController,
                          isPasswordType: false),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 50,
                      child: AuthTextField(
                          text: "Enter Email",
                          icon: Icons.email_outlined,
                          controller: _emailTextController,
                          isPasswordType: false),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 50,
                      child: AuthTextField(
                          text: "Enter Address",
                          icon: Icons.person_outline,
                          controller: _addressTextController,
                          isPasswordType: false),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 50,
                      child: AuthTextField(
                          text: "Enter Phone Number",
                          icon: Icons.person_outline,
                          controller: _phoneNumberTextController,
                          isPasswordType: false),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 50,
                      child: AuthTextField(
                          text: "Enter Password",
                          icon: Icons.lock_outline,
                          controller: _passwordTextController,
                          isPasswordType: true),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: AuthButton(isLogin: false, onTap: () => signUp()),
                  ),
                ]),
              ),
            )));
  }
}
