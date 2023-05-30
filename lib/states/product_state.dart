
import 'package:equatable/equatable.dart';

import '../models/error_model.dart';
import '../models/product_model.dart';

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetProductsLoadingState extends ProductState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetProductsSuccessState extends ProductState {
  final ProductModel productModel;
  GetProductsSuccessState(
      {required this.productModel });
  @override
  // TODO: implement props
  List<Object> get props =>
      [productModel];
}

class GetProductsErrorState extends ProductState {
  final ErrorModel errorModel;
  GetProductsErrorState({required this.errorModel,});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}

class GetProductsByCategoryLoadingState extends ProductState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetProductsByCategorySuccessState extends ProductState {
  final ProductModel productModel;
  GetProductsByCategorySuccessState(
      {required this.productModel });
  @override
  // TODO: implement props
  List<Object> get props =>
      [productModel];
}

class GetProductsByCategoryErrorState extends ProductState {
  final ErrorModel errorModel;
  GetProductsByCategoryErrorState({required this.errorModel,});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}
