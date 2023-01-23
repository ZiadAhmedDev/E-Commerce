class SearchModel {
  bool? status;
  Data? data;

  SearchModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Product>? data;

  Data.fromJson(Map<dynamic, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  num? id;
  dynamic price;
  bool? discount;
  String? name;
  dynamic image;
  dynamic description;
  bool? inFavorites;
  bool? inCart;

  Product.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
