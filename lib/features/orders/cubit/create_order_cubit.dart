// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/orders/repository/order_repository.dart';

class CreateOrderCubit extends Cubit<CommonState> {
  OrderRepository repository;
  CreateOrderCubit({
    required this.repository,
  }) : super(CommonInitialState());

  createOrder(
      {required String address,
      required String city,
      required String phone,
      required String fullName}) async {
    emit(CommonLoadingState());
    final res = await repository.createOrder(
        address: address, city: city, phone: phone, fullName: fullName);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
