import 'package:ecommerce_app/features/auth/cubit/sign_up_cubit.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';
import 'package:ecommerce_app/features/auth/ui/widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPages extends StatelessWidget {
  const SignupPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignUpCubit(repository: context.read<UserRepository>()),
      child: SignupWidgets(),
    );
  }
}
