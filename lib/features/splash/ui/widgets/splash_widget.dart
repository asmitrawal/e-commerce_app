import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:ecommerce_app/features/dashboard/ui/screens/dashboard_screens.dart';
import 'package:ecommerce_app/features/onboarding/onboarding_screen.dart';
import 'package:ecommerce_app/features/splash/cubit/startup_cubit.dart';
import 'package:ecommerce_app/features/splash/model/startup_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    context.read<StartUpCubit>().fetchInitialData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<StartUpCubit, CommonState>(
        listener: (context, state) {
          
          if (state is CommonSuccessState<StartUpData>) {
            if (state.item.isFirstTime) {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: OnboardingView(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
            } else if (state.item.isLoggedIn) {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: DashboardScreens(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: LoginPage(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
            }
          }
        },
        child: BlocBuilder<StartUpCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoadingState) {
              return Container(
                color: Colors.white,
                width: _width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.logo,
                      height: 260,
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: Colors.white,
                width: _width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.logo,
                      height: 260,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
