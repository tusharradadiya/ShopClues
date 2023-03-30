import 'package:database/screen/home/controller/homeController.dart';
import 'package:database/utils/fbhelper.dart';
import 'package:database/utils/sharedhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("  Personal Information",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),

            Card(elevation: 5,
              child: ListTile(
                leading: Icon(Icons.person,size: 40,),
                title: Text("Name : ${FB_Helper.fb_helper.firebase.currentUser!=null?FB_Helper.fb_helper.firebase.currentUser!.displayName:"admin" }"),

                subtitle: Text("Email   : ${FB_Helper.fb_helper.firebase.currentUser!=null ?FB_Helper.fb_helper.firebase.currentUser!.email:"admin@gmail.com" }"),
              ),
            ),
            Spacer(),
            Card(
              child: ListTile(
                  title: Text("Add Account"), leading: Icon(Icons.add)),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.defaultDialog(
                    title: "",
                    content: Text("Log Out From ShopClues?"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          homeController.changeScreen.value = 0;
                          FB_Helper.fb_helper.logout();
                          homeController.showNotiFication(
                              'Logout Account', "Tap to Login");
                          Sharedhelper.sharedhelper.islogin(false);
                          Get.offAllNamed('signin');
                        },
                        child: Text("Log Out"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, elevation: 2),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
                title: Text("Log Out"),
                leading: Icon(Icons.logout),
              ),
            )
          ],
        ),
      ),
    );
  }
}
