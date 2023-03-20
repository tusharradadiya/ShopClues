import 'package:database/screen/sign_in/view/signinPage.dart';
import 'package:database/utils/fbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool? _passwordVisible = false;
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();

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
                      children: [
                        Image.asset(
                          "assets/image/arrow.png",
                          height: 120,
                          width: 120,
                        ),
                        Text(
                          "Create",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                            color: Color(0xff4b74a6),
                          ),
                        ),
                        Text(
                          "account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff4b74a6),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: txtemail,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              label: Text("E-mail"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            obscureText: !_passwordVisible!,
                            controller: txtpass,
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
                                  // Update the state i.e. toogle the state of passwordVisible variable
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
                              bool issucces = await FB_Helper.fb_helper
                                  .sign_up(txtemail.text, txtpass.text);
                              if(issucces){
                                Get.snackbar("SuccessFul", "");
                                txtpass.clear();
                                txtemail.clear();
                                Get.off(SignInPage());
                              }else{
                                Get.snackbar("Error", "");

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
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 670,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.offNamed('signin');
                                },
                                child: Text(
                                  " Sign in",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        )
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
