import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/common/services/shared_pref_services.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';
import 'package:ecommerce_app/features/splash/model/startup_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartUpCubit extends Cubit<CommonState> {
  UserRepository repository;
  StartUpCubit({required this.repository}) : super(CommonInitialState());

  fetchInitialData() async {
    emit(CommonLoadingState());
    await repository.initialize();
    // await Future.delayed(Duration(milliseconds: 1000));
    final isFirstTime = await SharedPrefServices.isFirstTime;
    emit(CommonSuccessState(
      item: StartUpData(
          isLoggedIn: (repository.user != null && repository.token.isNotEmpty),
          isFirstTime: isFirstTime),
    ));
  }
}
