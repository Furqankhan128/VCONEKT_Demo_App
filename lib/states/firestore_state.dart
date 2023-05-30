
import 'package:equatable/equatable.dart';
import 'package:vconekt_demo_app/models/success_model.dart';

import '../models/error_model.dart';
import '../models/product_model.dart';

abstract class FireStoreState extends Equatable {}

class FireStoreInitialState extends FireStoreState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetFireStoreProductsLoadingState extends FireStoreState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetFireStoreProductsSuccessState extends FireStoreState {
  final ProductModel productModel;
  GetFireStoreProductsSuccessState(
      {required this.productModel });
  @override
  // TODO: implement props
  List<Object> get props =>
      [productModel];
}

class GetFireStoreProductsErrorState extends FireStoreState {
  final ErrorModel errorModel;
  GetFireStoreProductsErrorState({required this.errorModel,});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}


class CreateProductLoadingState extends FireStoreState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateProductSuccessState extends FireStoreState {
  final SuccessModel successModel;
  CreateProductSuccessState(
      {required this.successModel });
  @override
  // TODO: implement props
  List<Object> get props =>
      [successModel];
}

class CreateProductErrorState extends FireStoreState {
  final ErrorModel errorModel;
  CreateProductErrorState({required this.errorModel,});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}


class UpdateProductLoadingState extends FireStoreState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateProductSuccessState extends FireStoreState {
  final SuccessModel successModel;
  UpdateProductSuccessState(
      {required this.successModel });
  @override
  // TODO: implement props
  List<Object> get props =>
      [successModel];
}

class UpdateProductErrorState extends FireStoreState {
  final ErrorModel errorModel;
  UpdateProductErrorState({required this.errorModel,});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}


class DeleteProductLoadingState extends FireStoreState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DeleteProductSuccessState extends FireStoreState {
  final SuccessModel successModel;
  DeleteProductSuccessState(
      {required this.successModel });
  @override
  // TODO: implement props
  List<Object> get props =>
      [successModel];
}

class DeleteProductErrorState extends FireStoreState {
  final ErrorModel errorModel;
  DeleteProductErrorState({required this.errorModel,});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}



