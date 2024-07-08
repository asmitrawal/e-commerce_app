// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';

class AddToCartCubit extends Cubit<CommonState> {
  ProductRepository repository;
  AddToCartCubit({
    required this.repository,
  }) : super(CommonInitialState());

  addToCart ({required String productId}) async {
    emit(CommonLoadingState());
    final res = await repository.addToCart(productId: productId );
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState(item: null)));
  }
}
