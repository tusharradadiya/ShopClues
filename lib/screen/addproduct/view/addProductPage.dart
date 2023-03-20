import 'package:database/screen/home/controller/homeController.dart';
import 'package:database/utils/fbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: key,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "Add Product",
              style: GoogleFonts.secularOne(fontSize: 21, color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: homeController.txtpname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Product Name";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Product Name",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: homeController.txtpprice,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Product price";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Product price",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: homeController.txtdesc,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Discribssion",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: homeController.txtpcat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Product category";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Product category",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: homeController.txtpimage,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Product Image";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Product Image",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        FB_Helper.fb_helper.addData(
                            name: homeController.txtpname.text.toLowerCase(),
                            disc:  homeController.txtdesc.text,
                            image: homeController.txtpimage.text,
                            category: homeController.txtpcat.text.toLowerCase(),
                            price: homeController.txtpprice.text);
                        homeController.txtpprice.clear();
                        homeController.txtpcat.clear();
                        homeController.txtpimage.clear();
                        homeController.txtpname.clear();
                        homeController.txtdesc.clear();
                        Get.back();
                      }
                    },
                    child: Text("Add Procuct"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
