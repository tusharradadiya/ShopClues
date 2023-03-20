class HomeModel {
  String? image, name, category, price,id,desc;
  List? iList = [];

  HomeModel({this.image, this.name, this.category, this.price,this.id,this.desc,this.iList});

  // HomeModel FromMap(Map map) {
  //   HomeModel h1 = HomeModel(
  //     price: map['price'],
  //     name: map['name'],
  //     image: map['image'],
  //     category: map['category'],
  //     id: map['id'],
  //   );
  //   return h1;
  // }
}
