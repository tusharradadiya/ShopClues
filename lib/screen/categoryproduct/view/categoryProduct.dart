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

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({Key? key}) : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
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
            "${homeController.h1.category}".toUpperCase(),
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
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                        homeController.cetdatalist.clear();
                        for (var q in y) {
                          Map data = q.data() as Map;
                          HomeModel h1 = HomeModel(
                              image: data['image'],
                              name: data['name'],
                              price: data['price'],
                              id: q.id,
                              desc: data['disc'],
                              category: data['category']);
                          homeController.cetdatalist.add(h1);
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
                            itemCount: homeController.cetdatalist.length,
                            itemBuilder: (context, index) => FocusedMenuHolder(
                              onPressed: () {},
                              menuWidth: 100,
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
                                          "${homeController.cetdatalist[index].name}");
                                    }),
                                FocusedMenuItem(
                                    title: Text("update"),
                                    trailingIcon: Icon(Icons.edit),
                                    onPressed: () {}),
                                FocusedMenuItem(
                                  title: Text(
                                    "delete",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  trailingIcon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    FB_Helper.fb_helper.deleteData(
                                        "${homeController.cetdatalist[index].id}");
                                  },
                                ),
                              ],
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    homeController.h1 =
                                        homeController.cetdatalist[index];
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
                                              "${homeController.cetdatalist[index].image}",
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return CircularProgressIndicator();
                                              },
                                              height: 90,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            "${homeController.cetdatalist[index].name}",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Rs.${homeController.cetdatalist[index].price}",
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
                    stream: FB_Helper.fb_helper
                        .readcetData("${homeController.h1.category}"),
                  ),
                ],
              ),
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
