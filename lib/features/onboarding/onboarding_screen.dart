import 'package:ecommerce_app/common/services/shared_pref_services.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: Text(
              "Welcome",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            body: "Follow these instructions ",
            image: Image.asset(
              "assets/images/onboarding_1.png",
              height: 180,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              "Almost there..",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            body: "You got this",
            image: Image.asset(
              "assets/images/onboarding_2.png",
              height: 180,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              "All Set",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            body: "You're good to go!",
            image: Image.asset(
              "assets/images/onboarding_3.png",
              height: 180,
            ),
          ),
        ],
        done: const Text("Done"),
        onDone: () {
          SharedPrefServices.setAppOpenFlag();
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: LoginPage(),
              type: PageTransitionType.fade,
            ),
            (route) => false,
          );
        },
        skip: const Text("Skip"),
        showSkipButton: true,
        onSkip: () {
          SharedPrefServices.setAppOpenFlag();
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: LoginPage(),
              type: PageTransitionType.fade,
            ),
            (route) => false,
          );
        },
        next: const Text("Next"),
      ),
    );
  }
}
