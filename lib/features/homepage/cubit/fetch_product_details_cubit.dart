// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/homepage/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';

class FetchProductCubit extends Cubit<CommonState> {
  ProductRepository repository;
  FetchProductCubit({
    required this.repository,
  }) : super(CommonInitialState());

  fetchProductDetails({required String productId}) async {
    emit(CommonLoadingState());
    final res = await repository.fetchProductDetails(productId: productId );
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState<Product>(item: data)));
  }
}
