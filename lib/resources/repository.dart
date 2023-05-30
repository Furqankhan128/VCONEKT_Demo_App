

import 'package:dartz/dartz.dart';

import '../models/category_model.dart';
import '../models/error_model.dart';
import '../models/product_model.dart';
import '../models/success_model.dart';
import 'api_provider.dart';

class Repository {
  final ApiProvider _apiProvider = ApiProvider();


  Future<Either<ErrorModel, SuccessModel>> getProducts() async =>
      _apiProvider.get(
          authorization: false,
          path: "https://dummyjson.com/products",
          getModel: (data) => ProductModel.fromJson(parsedJson: data));

  Future<Either<ErrorModel, SuccessModel>> getProductsByCategory(
      {required category}) async =>
      _apiProvider.get(
          authorization: false,
          path: "https://dummyjson.com/products/category/$category",
          getModel: (data) => ProductModel.fromJsonCategoryProducts(parsedJson: data));

  Future<Either<ErrorModel, SuccessModel>> getCategories() async =>
      _apiProvider.get(
          authorization: false,
          path: "https://dummyjson.com/products/categories",
          getModel: (data) => CategoryModel.fromJson(parsedJson: data));

}
