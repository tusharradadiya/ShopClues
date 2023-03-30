import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database/screen/home/controller/homeController.dart';
import 'package:database/screen/home/model/homemodel.dart';
import 'package:database/utils/fbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    homeController.initNotification();
    homeController.fireMessage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SmartRefresher(
          enablePullDown: true,
          physics: BouncingScrollPhysics(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          header: ClassicHeader(),
          controller: _refreshController,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              homeController.h1 =
                                  homeController.categoryList[index];
                              FB_Helper.fb_helper.readcetData(
                                  "${homeController.categoryList[index].category}");
                              Get.toNamed("cp");
                            },
                            child: Container(
                              width: 65,
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  "${homeController.categoryList[index].image}",
                                  errorBuilder:
                                      (context, child, loadingProgress) {
                                    return CircularProgressIndicator();
                                  },
                                  height: 55,
                                ),
                              ),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black54, width: 1),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text("${homeController.categoryList[index].category}"
                              .toUpperCase()),
                        ],
                      ),
                      itemCount: homeController.categoryList.length,
                    ),
                  ),
                  Text(
                    "Popular Product",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        var y = snapshot.data!.docs;
                        homeController.datalist.clear();
                        for (var q in y) {
                          Map data = q.data() as Map;
                          HomeModel h1 = HomeModel(
                              image: data['image'],
                              name: data['name'],
                              price: data['price'],
                              id: q.id,
                              desc: data['disc'],
                              category: data['category'],
                          );
                          homeController.datalist.add(h1);
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
                            itemCount: homeController.datalist.length,
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
                                          "${homeController.datalist[index].name}");
                                    }),
                                FocusedMenuItem(
                                    title: Text("update"),
                                    trailingIcon: Icon(Icons.edit),
                                    onPressed: () {}),
                                FocusedMenuItem(
                                  title: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  trailingIcon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    FB_Helper.fb_helper.deleteData(
                                        "${homeController.datalist[index].id}");
                                  },
                                ),
                              ],
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    homeController.h1 =
                                        homeController.datalist[index];
                                    Get.toNamed('detail');
                                  },
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                  "${homeController.datalist[index].image}",
                                                  height: 90,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "${homeController.datalist[index].name}",
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Rs.${homeController.datalist[index].price}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 7,
                              mainAxisExtent: 200),
                          itemCount: homeController.datalist.length,
                          itemBuilder: (context, index) => Shimmer.fromColors(
                            baseColor: Color(0xfccc4c4),
                            highlightColor: Colors.white70,
                            child: Card(
                              child:Container(),
                              elevation: 4,
                            ),
                          ),
                        );},
                    stream: FB_Helper.fb_helper.readData(),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('add');
          },
          backgroundColor: Colors.blue,
          elevation: 10,
          child: Icon(
            Icons.add,
            color: Colors.white,
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
