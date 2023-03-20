import 'package:carousel_slider/carousel_slider.dart';
import 'package:database/screen/home/controller/homeController.dart';
import 'package:database/utils/fbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  HomeController homeController = Get.put(HomeController());
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            "Product Detail",
            style: GoogleFonts.secularOne(fontSize: 21, color: Colors.black),
          ),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          physics: BouncingScrollPhysics(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          header: ClassicHeader(),
          controller: _refreshController,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: 350,
                          child: CarouselSlider.builder(
                            itemCount: 0,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                width: double.infinity,
                                height: 300,
                                alignment: Alignment.center,
                                child: Image.network(
                                  "${homeController.h1.image}",
                                  height: 200,
                                ),
                              );
                            },
                            options: CarouselOptions(onPageChanged: (index, reason) {
                              homeController.map.value = index;
                            },),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Share.share(
                                '${homeController.h1.desc}',
                              );
                            },
                            icon: Icon(
                              Icons.share,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.save_alt,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${homeController.h1.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                      Text(
                        "Rs. ${homeController.h1.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Details:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${homeController.h1.desc}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Rating:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star_border,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star_border,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              bool iscart = await FB_Helper.fb_helper
                                  .updateData(
                                      name: "${homeController.h1.name}",
                                      disc: "${homeController.h1.desc}",
                                      id: "${homeController.h1.id}",
                                      category: "${homeController.h1.category}",
                                      image: "${homeController.h1.image}",
                                      price: "${homeController.h1.price}",
                                      iscart: true);

                              if (iscart == true) {
                                Get.back();
                                Get.snackbar(
                                  "Successfully",
                                  "view Cart",
                                  barBlur: 10,
                                  onTap: (snack) {
                                    homeController.changeScreen.value = 2;
                                  },
                                );
                              } else {
                                Get.snackbar("Please try again", "");
                              }
                            },
                            child: Text("ADD TO CART"),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}
