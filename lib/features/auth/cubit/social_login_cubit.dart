// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';

class SocialLoginCubit extends Cubit<CommonState> {
  final UserRepository repository;
  SocialLoginCubit({
    required this.repository,
  }) : super(CommonInitialState());

  facebookLogin() async {
    emit(CommonLoadingState());
    final res = await repository.facebookLogin();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }

  googleLogin() async {
    emit(CommonLoadingState());
    final res = await repository.googleLogin();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(item: data)),
    );
  }
}
