import 'dart:math';

class ProductModel {
  final List<Product> _products = [];

  final List<Product> _categoryProducts = [];

  ProductModel.fromJson({parsedJson}) {
    for (var item in parsedJson["products"]) {
      _products.add(Product(item));
    }
  }

  ProductModel.fromJsonCategoryProducts({parsedJson}) {
    for (var item in parsedJson["products"]) {
      _categoryProducts.add(Product(item));
    }
  }

  List<Product> get categoryProducts => _categoryProducts;

  List<Product> get products => _products;
}

class Product {
  late final int? _productId;
  late final String? _title;
  late final String? _description;
  late final int? _price;
  late final double? _discountPercentage;
  late final double? _rating;
  late final int? _stock;
  late final String? _brand;
  late final String? _category;
  late final String? _thumbnail;
  List<String> _images = [];

  Product(product) {
    _productId = product["id"]??Random().nextInt(1000);
    _title = product["title"]??"";
    _description = product["description"]??"";
    _price = product["price"]??0;
    _discountPercentage = product["discountPercentage"]??0.0;
    _rating = Random().nextDouble()*5;
    _stock = product["stock"]??0;
    _brand = product["brand"]??"";
    _category = product["category"]??"";
    _thumbnail = product["thumbnail"]??"";
    if(product["images"]!=null || product["images"]!=""){
      for (var image in product["images"]) {
        _images.add(image??"");
      }
    }
  }

  List<String> get images => _images;

  String? get thumbnail => _thumbnail;

  String? get category => _category;

  String? get brand => _brand;

  int? get stock => _stock;

  double? get rating => _rating;

  double? get discountPercentage => _discountPercentage;

  int? get price => _price;

  String? get description => _description;

  String? get title => _title;

  int? get productId => _productId;
}



class FireStoreProduct {
  final String productId;
  final String title;
  final String price;


  FireStoreProduct({required this.productId, required this.title, required this.price});
}
