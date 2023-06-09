import 'dart:async';
import 'package:database/utils/fbhelper.dart';
import 'package:database/utils/sharedhelper.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<void> holdScreen() async {
    bool? islogin = await Sharedhelper.sharedhelper.readlogin();
    bool isLogin = await FB_Helper.fb_helper.checkUser();
    if (isLogin || islogin==true) {
      Timer(
        Duration(seconds: 7),
        () {
          Get.offNamed('nav');
        },
      );
    } else {
      Timer(
        Duration(seconds: 7),
        () {
          Get.offNamed('signin');
        },
      );
    }
  }
}
