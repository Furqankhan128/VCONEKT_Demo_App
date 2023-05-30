import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/product_event.dart';
import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/success_model.dart';
import '../states/product_state.dart';

class GetProductsByCategoryBloc extends Bloc<ProductEvent, ProductState> {
  GetProductsByCategoryBloc(ProductState initialState) : super(initialState);

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is GetProductsByCategory) {
      yield GetProductsByCategoryLoadingState();

      Either<ErrorModel, SuccessModel> response =
      await gRepository.getProductsByCategory(category:event.category);

      yield response.fold((l) => GetProductsByCategoryErrorState(errorModel: l),
              (r) => GetProductsByCategorySuccessState(productModel: r.data));
    }
  }
}
