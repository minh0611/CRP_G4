import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authfb_demo/Screens/aboutUs.dart';
import 'package:flutter_authfb_demo/widgets/drawer_expandable.dart';
import 'package:flutter_authfb_demo/widgets/dropdown_cate.dart';
import 'package:flutter_authfb_demo/Screens/signin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late String? uFullname;

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(224, 15, 28, 70),
          content: const Text("Are you sure you want to sign out",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen())),
              child: const Text('Sign me out ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: Drawer(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.only(top: 35, left: 40),
                width: 305,
                height: 180,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(224, 15, 28, 70),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Welcome Back, ',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidCircleUser,
                          color: Colors.grey,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FutureBuilder(
                            future: _fetch(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return (const Text("Loading... Please wait"));
                              } else {
                                return Text(
                                  " $uFullname",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            }),
                      ],
                    ),
                  ],
                )),
            Container(
              child: SizedBox(
                width: 305,
                height: 500,
                child: ListView(
                  children: [
                    const DrawerExpandable(
                      cateName: "Men",
                      // ignore: deprecated_member_use
                      cateIcon: 'assets/icon_images/men.png',
                    ),
                    const DrawerExpandable(
                      cateName: "Women",
                      // ignore: deprecated_member_use
                      cateIcon: 'assets/icon_images/women.png',
                    ),
                    const DrawerExpandable(
                      cateName: "Kid",
                      cateIcon: 'assets/icon_images/kid.png',
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 15, left: 15, top: 10),
                      height: 50,
                      color: Colors.white,
                      child: InkWell(
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 12,
                            ),
                            FaIcon(
                              FontAwesomeIcons.circleInfo,
                              size: 30,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              ' About us',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const AboutUsScreen();
                            },
                          ));
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      height: 50,
                      color: Colors.white,
                      child: InkWell(
                        onTap: () => signOut(),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 12,
                            ),
                            FaIcon(
                              FontAwesomeIcons.rightFromBracket,
                              size: 30,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              ' Log Out',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        uFullname = ds.data()!['fullname'];
        print(uFullname);
      }).catchError((e) {
        print(e);
      });
    }
  }
}
