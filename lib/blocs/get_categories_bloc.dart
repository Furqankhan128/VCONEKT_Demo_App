
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/category_event.dart';
import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/success_model.dart';
import '../states/category_state.dart';

class GetCategoriesBloc extends Bloc<CategoryEvent, CategoryState> {
  GetCategoriesBloc(CategoryState initialState) : super(initialState);

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is GetCategories) {
      yield GetCategoriesLoadingState();

      Either<ErrorModel, SuccessModel> response = await gRepository.getCategories();

      yield response.fold((l) => GetCategoriesErrorState(errorModel: l),
              (r) => GetCategoriesSuccessState(categoryModel: r.data));
    }

    else if (event is ResetCategories) {
      yield CategoryInitialState();
    }
  }
}
