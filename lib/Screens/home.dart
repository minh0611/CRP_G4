import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authfb_demo/Screens/cart.dart';
import 'package:flutter_authfb_demo/Screens/drawer.dart';
import 'package:flutter_authfb_demo/Screens/favourite.dart';
import 'package:flutter_authfb_demo/Screens/home_body.dart';
import 'package:flutter_authfb_demo/Screens/home_new.dart';
import 'package:flutter_authfb_demo/Screens/home_personal.dart';
import 'package:flutter_authfb_demo/Screens/home_product.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:flutter/services.dart';

final List<String> imgList = [
  'assets/images/banner.jpeg',
  'assets/images/banner2.jpeg',
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchTextController = TextEditingController();
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: const Color.fromARGB(224, 15, 28, 70),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(
                        Icons.menu_outlined,
                        color: Colors.white,
                      )),
                ),
                Row(
                  children: const [
                    Text(
                      "LMSD",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "SPORT",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const FavouriteScreen();
                            },
                          ));
                        },
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.shopping_cart_checkout_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const CartScreen();
                            },
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        drawer: const DrawerScreen(),
        body: PageView(
          scrollDirection: axisDirectionToAxis(AxisDirection.right),
          controller: pageController,
          children: const <Widget>[
            HomeBodyScreen(),
            HomeProductScreen(),
            HomeNewScreen(),
            HomePersonalScreen(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: navigationBarColor,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
                filledIcon: Icons.shopping_bag_rounded,
                outlinedIcon: Icons.shopping_bag_outlined),
            BarItem(
              filledIcon: Icons.newspaper_rounded,
              outlinedIcon: Icons.newspaper_outlined,
            ),
            BarItem(
              filledIcon: Icons.person_2_rounded,
              outlinedIcon: Icons.person_2_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
