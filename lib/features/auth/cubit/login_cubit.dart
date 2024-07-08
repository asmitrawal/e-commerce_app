import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class loginCubit extends Cubit<CommonState> {
  final UserRepository repository;
  loginCubit({required this.repository}) : super(CommonInitialState());

  login({required String email, required String password}) async {
    emit(CommonLoadingState());
    final res = await repository.login(email: email, password: password);
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState(item: data)));
  }
}
