import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database/screen/home/controller/homeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/fbhelper.dart';
import '../../home/model/homemodel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  HomeController homeController = Get.put(HomeController());
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    total();
    return SafeArea(
      child: Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          header: ClassicHeader(),
          controller: _refreshController,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        var y = snapshot.data!.docs;
                        homeController.cartList.clear();
                        for (var q in y) {
                          Map data = q.data() as Map;
                          HomeModel h1 = HomeModel(
                              image: data['image'],
                              name: data['name'],
                              price: data['price'],
                              id: q.id,
                              desc: data['disc'],
                              category: data['category']);
                          homeController.cartList.add(h1);
                        }
                        // homeController.datalist.value =
                        //     l1.map((e) => HomeModel().FromMap(e)).toList();

                        return Obx(
                          () => GridView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 7,
                                    mainAxisExtent: 200),
                            itemCount: homeController.cartList.length,
                            itemBuilder: (context, index) => FocusedMenuHolder(
                              onPressed: () {},
                              menuWidth: 120,
                              blurSize: 1,
                              menuItemExtent: 45,
                              menuBoxDecoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              duration: Duration(milliseconds: 100),
                              animateMenuItems: true,
                              blurBackgroundColor: Colors.black54,
                              menuItems: <FocusedMenuItem>[
                                FocusedMenuItem(
                                    title: Text("Share"),
                                    trailingIcon: Icon(Icons.share),
                                    onPressed: () {
                                      Share.share(
                                          "${homeController.cartList[index].name}");
                                    }),
                                FocusedMenuItem(
                                    title: Text("update"),
                                    trailingIcon: Icon(Icons.edit),
                                    onPressed: () {}),
                                FocusedMenuItem(
                                  title: Text(
                                    "Remove",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  trailingIcon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    FB_Helper.fb_helper.updateData(
                                        name:
                                            "${homeController.cartList[index].name}",
                                        disc:
                                            "${homeController.cartList[index].desc}",
                                        id:
                                            "${homeController.cartList[index].id}",
                                        iscart: false,
                                        category:
                                            "${homeController.cartList[index].category}",
                                        image:
                                            "${homeController.cartList[index].image}",
                                        price:
                                            "${homeController.cartList[index].price}");
                                  },
                                ),
                              ],
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    homeController.h1 =
                                        homeController.cartList[index];
                                    Get.toNamed('detail');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          Center(
                                            child: Image.network(
                                              "${homeController.cartList[index].image}",
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return CircularProgressIndicator();
                                              },
                                              height: 90,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            "${homeController.cartList[index].name}",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Rs.${homeController.cartList[index].price}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    stream: FB_Helper.fb_helper.readCartData(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15),
              Text(
                "Total Rs. 2000",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text("Buy Now"),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(100, 20),
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
          height: 45,
          margin: EdgeInsets.only(bottom: 1),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1),
            ],
          ),
        ),
      ),
    );
  }

  void total() {
    // var docs = FB_Helper.fb_helper.readCartData() ;
    // docs.
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
