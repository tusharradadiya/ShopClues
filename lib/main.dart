import 'package:database/screen/addproduct/view/addProductPage.dart';
import 'package:database/screen/cart/view/cartPage.dart';
import 'package:database/screen/categoryproduct/view/categoryProduct.dart';
import 'package:database/screen/home/view/homePage.dart';
import 'package:database/screen/navigator/view/navigator.dart';
import 'package:database/screen/productdetail/view/detailPage.dart';
import 'package:database/screen/profile/view/profilePage.dart';
import 'package:database/screen/sign_in/view/signinPage.dart';
import 'package:database/screen/sign_up/view/signupPage.dart';
import 'package:database/screen/splash/view/splashcreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        'nav': (context) => NavigatorPage(),
        'signin': (context) => SignInPage(),
        'signup': (context) => SignupPage(),
        'home': (context) => HomePage(),
        'add': (context) => AddProductPage(),
        'detail': (context) => ProductDetailPage(),
        'cart': (context) => CartPage(),
        'cp': (context) => CategoryProduct(),
        'profile': (context) => ProfilePage(),
      },
    ),
  );
}
