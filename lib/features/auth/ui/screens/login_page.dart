import 'package:ecommerce_app/features/auth/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/cubit/social_login_cubit.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';
import 'package:ecommerce_app/features/auth/ui/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => loginCubit(
            repository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SocialLoginCubit(
            repository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: const LoginWidgets(),
    );
  }
}
