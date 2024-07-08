// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';

class FetchCartCubit extends Cubit<CommonState> {
  CartRepository repository;
  FetchCartCubit({
    required this.repository,
  }) : super(CommonInitialState());

  fetchCart() async {
    emit(CommonLoadingState());
    final res = await repository.fetchCart();
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState(item: data)));
  }

  refreshCart() async {
    emit(CommonLoadingState());
    emit(CommonSuccessState(item: repository.cart));
  }
}
