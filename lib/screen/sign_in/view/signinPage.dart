import 'package:database/screen/home/controller/homeController.dart';
import 'package:database/utils/fbhelper.dart';
import 'package:database/utils/sharedhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    homeController.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 23.5,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/image/bg.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/image/arrow.png",
                          height: 120,
                          width: 120,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            controller: txtemail,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              label: Text("Username"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            controller: txtpass,
                            obscureText: !_passwordVisible!,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              label: Text("Password"),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: InkWell(
                            onTap: () async {
                              bool issignin = await FB_Helper.fb_helper
                                  .sign_in(txtemail.text, txtpass.text);
                              if (issignin) {
                                homeController.changeScreen.value = 0;

                                homeController.showNotiFication(
                                    "Login Successful",
                                    "Happy journey with ShopClues");
                                Get.offNamed('nav');
                                txtpass.clear();
                                txtemail.clear();
                              } else {
                                Get.snackbar("Error", "Detail is Incorrect");
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [Color(0xff4b74a6), Colors.blue]),
                              ),
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 58,
                                width: 58,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/image/linklin.png",
                                  height: 58,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                bool isLogin = await FB_Helper.fb_helper
                                    .signInWithGoogle();
                                if (isLogin) {
                                  homeController.changeScreen.value = 0;
                                  homeController.showNotiFication(
                                      "Login Successful",
                                      "Happy journey with ShopClues");
                                  Get.offNamed('nav');
                                }
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/image/google.png",
                                  height: 60,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 48,
                                width: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // border: Border.all(color: Colors.red, width: 2),
                                ),
                                child: Image.asset(
                                  "assets/image/facebook.png",
                                  height: 48,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 800,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offNamed('signup');
                              },
                              child: Text(
                                " Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 730,
                        ),
                        TextButton(
                          onPressed: () {
                            Sharedhelper.sharedhelper.islogin(true);
                            Get.offNamed('nav');
                          },
                          child: Text(
                            "Guest Mode",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white,
                              decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
