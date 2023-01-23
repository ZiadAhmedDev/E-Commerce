class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<HomeDataBanner> banners = [];
  List<HomeDataProduct> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(HomeDataBanner.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(HomeDataProduct.fromJson(element));
    });
  }
}

class HomeDataBanner {
  int? id;
  String? image;

  HomeDataBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class HomeDataProduct {
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  HomeDataProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
