// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';

class SignUpCubit extends Cubit<CommonState> {
  final UserRepository repository;
  SignUpCubit({
    required this.repository,
  }) : super(CommonInitialState());

  signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    emit(CommonLoadingState());
    final res = await repository.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        address: address);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
