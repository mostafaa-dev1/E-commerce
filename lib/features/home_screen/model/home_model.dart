
class HomeModel {
  bool? Status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    Status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel{
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
    print(products);
  }
}
class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map <String,dynamic> json){
  id = json['id'];
  image = json['image'];
  }
}
class ProductsModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  bool? inFavourites;
  bool? inCart;
  ProductsModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }


}