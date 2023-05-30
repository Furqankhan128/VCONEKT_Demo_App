import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/product_event.dart';
import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/success_model.dart';
import '../states/product_state.dart';

class GetProductsBloc extends Bloc<ProductEvent, ProductState> {
  GetProductsBloc(ProductState initialState) : super(initialState);

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is GetProducts) {
      yield GetProductsLoadingState();

      Either<ErrorModel, SuccessModel> response =
      await gRepository.getProducts();

      yield response.fold((l) => GetProductsErrorState(errorModel: l),
              (r) => GetProductsSuccessState(productModel: r.data));
    }


    else if (event is ResetProducts) {
      yield ProductInitialState();
    }
  }
}
