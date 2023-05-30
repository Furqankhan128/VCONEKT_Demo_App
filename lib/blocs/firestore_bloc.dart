
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vconekt_demo_app/states/firestore_state.dart';
import 'dart:convert';

import '../events/firestore_event.dart';
import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/product_model.dart';
import '../models/success_model.dart';
import '../states/auth_states.dart';

import '../user_session.dart';

class FireStoreBloc extends Bloc<FireStoreEvent, FireStoreState> {
  FireStoreBloc(FireStoreState initialState) : super(initialState);

  @override
  Stream<FireStoreState> mapEventToState(FireStoreEvent event) async* {
    if (event is CreateProduct) {
      yield CreateProductLoadingState();

      try {

        await gDatabase.collection('products').add({
          "title": event.name,
          "price": event.price
        });

         yield CreateProductSuccessState(successModel: SuccessModel(title: "Success",
            message: "New product has been added"));
      } catch (e) {
        yield CreateProductErrorState(errorModel: ErrorModel(
            message: e.toString(),
            title: "Error",
            errorCode: 500
        ));
      }
    }

    else if (event is UpdateProduct) {
      yield UpdateProductLoadingState();

      try {

        await gDatabase.collection("products").doc(event.productId).update(<String, dynamic>{
          "title": event.name,
          "price": event.price
        });

        yield UpdateProductSuccessState(successModel: SuccessModel(title: "Success",
            message: "Product has been updated"));
      } catch (e) {
        yield UpdateProductErrorState(errorModel: ErrorModel(
            message: e.toString(),
            title: "Error",
            errorCode: 500
        ));
      }
    }

    else if (event is DeleteProduct) {
      yield DeleteProductLoadingState();

      try {

        await gDatabase.collection("products").doc(event.productId).delete();

        yield DeleteProductSuccessState(successModel: SuccessModel(title: "Success",
            message: "Product has been deleted"));
      } catch (e) {
        yield DeleteProductErrorState(errorModel: ErrorModel(
            message: e.toString(),
            title: "Error",
            errorCode: 500
        ));
      }
    }
  }
}