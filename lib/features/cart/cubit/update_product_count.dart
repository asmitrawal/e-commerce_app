// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';

class UpdateProductCountCubit extends Cubit<CommonState> {
  CartRepository repository;
  UpdateProductCountCubit({
    required this.repository,
  }) : super(CommonInitialState());

  updateProductCount({required String cartId, required int quantity}) async {
    emit(CommonLoadingState());
    final res =
        await repository.updateProductCount(cartId: cartId, quantity: quantity);
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState(item: data)));
  }
}
