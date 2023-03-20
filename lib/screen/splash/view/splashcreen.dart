import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:database/screen/splash/controller/splashControler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../sign_in/view/signinPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    splashController.holdScreen();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Lottie.asset("assets/lotiee/splash.json",height: 150),
        ),
      ),
    );
  }
}
