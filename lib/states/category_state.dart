
import 'package:equatable/equatable.dart';

import '../models/category_model.dart';
import '../models/error_model.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitialState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetCategoriesLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetCategoriesSuccessState extends CategoryState {
  final CategoryModel categoryModel;
  GetCategoriesSuccessState(
      {required this.categoryModel });
  @override
  // TODO: implement props
  List<Object> get props =>
      [categoryModel];
}

class GetCategoriesErrorState extends CategoryState {
  final ErrorModel errorModel;
  GetCategoriesErrorState({required this.errorModel,});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}
