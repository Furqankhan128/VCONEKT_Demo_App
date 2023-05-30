import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vconekt_demo_app/events/firestore_event.dart';
import 'package:vconekt_demo_app/states/firestore_state.dart';

import '../events/product_event.dart';
import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/success_model.dart';
import '../states/product_state.dart';

class GetFireStoreProductsBloc extends Bloc<FireStoreEvent, FireStoreState> {
  GetFireStoreProductsBloc(FireStoreState initialState) : super(initialState);

  @override
  Stream<FireStoreState> mapEventToState(FireStoreEvent event) async* {
    if (event is GetFireStoreProducts) {
      yield GetFireStoreProductsLoadingState();

      Either<ErrorModel, SuccessModel> response =
      await gRepository.getProducts();

      yield response.fold((l) => GetFireStoreProductsErrorState(errorModel: l),
              (r) => GetFireStoreProductsSuccessState(productModel: r.data));
    }


    else if (event is ResetProducts) {
      yield FireStoreInitialState();
    }
  }
}
