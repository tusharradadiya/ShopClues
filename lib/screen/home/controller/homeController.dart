import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../model/homemodel.dart';

class HomeController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int total = 0;
  RxInt changeScreen = 0.obs, map = 0.obs;
  RxString name = "".obs;
  TextEditingController txtpname = TextEditingController();
  TextEditingController txtpprice = TextEditingController();
  TextEditingController txtpcat = TextEditingController();
  TextEditingController txtpimage = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  RxList<HomeModel> datalist = <HomeModel>[].obs;
  RxList<HomeModel> cetdatalist = <HomeModel>[].obs;
  RxList<HomeModel> namedataList = <HomeModel>[].obs;
  RxList<HomeModel> cartList = <HomeModel>[].obs;
  RxList<HomeModel> categoryList = <HomeModel>[
    HomeModel(
      category: "mobile",
      image: "https://cdn1.smartprix.com/rx-ioKTQfBn2-w1200-h1200/oKTQfBn2.jpg",
    ),
    HomeModel(
      category: "grocery",
      image:
          "https://i.pinimg.com/originals/3d/5c/e8/3d5ce8662dac6c2e92a2ffd9f4b96d36.png",
    ),
    HomeModel(
      category: "furniture",
      image:
          "https://www.pngitem.com/pimgs/m/186-1867906_wood-furniture-png-wood-furniture-images-png-transparent.png",
    ),
    HomeModel(
      category: "tv",
      image:
          "https://e7.pngegg.com/pngimages/404/811/png-clipart-led-backlit-lcd-vestel-high-definition-television-smart-tv-smart-tv-miscellaneous-television.png",
    ),
    HomeModel(
      category: "clothes",
      image:
          "https://e7.pngegg.com/pngimages/236/406/png-clipart-assorted-clothes-t-shirt-clothing-jeans-laundry-casual-jeans-dress-textile-fashion.png",
    ),
  ].obs;

  HomeModel h1 = HomeModel();

  void initNotification() {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('logo');
    DarwinInitializationSettings iOSinitSettings =
        DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSinitSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotiFication(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "1",
      'Android',
      priority: Priority.min,
      importance: Importance.min,
          ongoing: true
    );
    DarwinNotificationDetails iOSNotificationDetails =
        DarwinNotificationDetails(subtitle: 'iOS');
    NotificationDetails notificationDetails = NotificationDetails(
        iOS: iOSNotificationDetails, android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1, '$title', '$body', notificationDetails);
  }

  Future<void> fireMessage() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var fcmToken = await firebaseMessaging.getToken();
    print("===============================>   $fcmToken");
    initNotification();
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      announcement: false,
      badge: false,
      criticalAlert: false,
      carPlay: false,
    );
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        var body = event.notification!.body;
        var title = event.notification!.title;
        showNotiFication("${title}", "${body}");
      }
    });
  }
}
