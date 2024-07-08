import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/homepage/model/product.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllProductsCubit extends Cubit<CommonState> {
  final ProductRepository repository;
  FetchAllProductsCubit({required this.repository})
      : super(CommonInitialState());

  fetchAllProducts() async {
    emit(CommonLoadingState());
    final res = await repository.fetchAllProducts();
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState<List<Product>>(item: data)));
  }
}
