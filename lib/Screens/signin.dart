import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/home.dart';
import 'package:flutter_authfb_demo/Screens/reset_password.dart';
import 'package:flutter_authfb_demo/utils/color_utils.dart';
import 'package:flutter_authfb_demo/widgets/auth_submit_button.dart';
import 'package:flutter_authfb_demo/widgets/custom_textfield.dart';
import 'package:flutter_authfb_demo/widgets/home_logo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(224, 15, 28, 70),
            content: const Text("Log in succesfully",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage())),
                child: const Text('OK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
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

  Future loginAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print("Log in Anonymously");
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(224, 15, 28, 70),
            content: const Text("Are you sure you want to proceed as a guest??",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage())),
                child: const Text('I am sure',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
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

  Future logInByFacebook() async {
    try {} on FirebaseAuthException catch (e) {
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

  Future loginbyGoogleAccount() async {
    try {} on FirebaseAuthException catch (e) {
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
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringColor("0F1C46"),
          hexStringColor("0F1C46"),
          hexStringColor("FFFFFF"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Form(
              child: Column(children: <Widget>[
                const HomeLogo(imageName: 'assets/images/logo.png'),
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: SizedBox(
                    height: 50,
                    child: AuthTextField(
                        text: "Enter Email: ",
                        icon: Icons.person_outline,
                        controller: _emailTextController,
                        isPasswordType: false),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: SizedBox(
                    height: 50,
                    child: AuthTextField(
                        text: "Enter Password: ",
                        icon: Icons.lock_outline,
                        controller: _passwordTextController,
                        isPasswordType: true),
                  ),
                ),
                SizedBox(
                  height: 75,
                  child: AuthButton(isLogin: true, onTap: () => signIn()),
                ),
                otherLoginOption(),
                const SizedBox(
                  height: 15,
                ),
                signUpOption(),
                resetPassword(),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.black, fontSize: 18)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            "  Sign Up",
            style: TextStyle(
                color: Color.fromARGB(224, 15, 28, 70),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        )
      ],
    );
  }

  Container resetPassword() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen()));
            },
            child: const Text(
              "  Forget Password",
              style: TextStyle(
                  color: Color.fromARGB(224, 15, 28, 70),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  Row otherLoginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => logInByFacebook(),
          icon: const FaIcon(FontAwesomeIcons.facebook),
          color: Colors.blue,
          iconSize: 40,
        ),
        IconButton(
          onPressed: () => loginbyGoogleAccount(),
          icon: const FaIcon(FontAwesomeIcons.google),
          color: Colors.red,
          iconSize: 40,
        ),
        IconButton(
          onPressed: () => loginAnonymously(),
          icon: const FaIcon(FontAwesomeIcons.user),
          color: Colors.grey,
          iconSize: 40,
        ),
      ],
    );
  }
}
