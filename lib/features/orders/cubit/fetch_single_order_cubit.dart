// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/orders/repository/order_repository.dart';

class FetchSinlgeOrderCubit extends Cubit<CommonState> {
  OrderRepository repository;
  FetchSinlgeOrderCubit({
    required this.repository,
  }) : super(CommonInitialState());

  fetchSingleOrders() async {
    emit(CommonLoadingState());
    final res = await repository.fetchSingleOrders();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
