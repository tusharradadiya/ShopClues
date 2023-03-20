import 'package:database/screen/cart/view/cartPage.dart';
import 'package:database/screen/home/controller/homeController.dart';
import 'package:database/screen/home/view/homePage.dart';
import 'package:database/screen/profile/view/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../search/view/searchpage.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  List pageList = [HomePage(), SearchPage(), CartPage(), ProfilePage()];
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: homeController.changeScreen == 2
                ? Text(
                    "My Cart",
                    style: GoogleFonts.secularOne(
                        fontSize: 21, color: Colors.black),
                  )
                : homeController.changeScreen == 3
                    ? Text(
                        " My Profile",
                        style: GoogleFonts.secularOne(
                            fontSize: 21, color: Colors.black),
                      )
                    : homeController.changeScreen == 1
                        ? Text(
                            "Search",
                            style: GoogleFonts.secularOne(
                                fontSize: 21, color: Colors.black),
                          )
                        : Row(
                            children: [
                              Image.asset("assets/image/bag.png", height: 25),
                              SizedBox(width: 5),
                              Text(
                                "ShopClues",
                                style: GoogleFonts.secularOne(
                                    fontSize: 21, color: Colors.black),
                              ),
                            ],
                          ),
          ),
          body: pageList[homeController.changeScreen.value],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.black54,
            selectedItemColor: Colors.black,
            currentIndex: homeController.changeScreen.value,
            onTap: (value) {
              homeController.changeScreen.value = value;
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                label: "Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
