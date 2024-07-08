
import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/orders/repository/order_repository.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';
import 'package:ecommerce_app/features/splash/ui/pages/splash_page.dart';

void main() async {
    runApp(MyApp());
  // runZonedGuarded<Future<void>>(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   // The following lines are the same as previously explained in "Handling uncaught errors"
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider(
            create: (context) => Dio()
              ..interceptors.add(
                InterceptorsWrapper(
                  onRequest: (options, handler) {
                    UserRepository userRepository =
                        context.read<UserRepository>();
                    options.headers["Authorization"] =
                        "Bearer ${userRepository.token}";
                    handler.next(options);
                  },
                ),
              ),
          ),
          RepositoryProvider(
            create: (context) => ProductRepository(
              userRepository: context.read<UserRepository>(),
              dio: context.read<Dio>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CartRepository(
              dio: context.read<Dio>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => OrderRepository(
              dio: context.read<Dio>(),
            ),
          ),
        ],
        child: KhaltiScope(
          publicKey: "test_public_key_a043390d7f0d4f4fb27f25dc14557aed",
          builder: (context, navigatorKey) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              title: 'Ecommerce',
              theme: ThemeData(
                primaryColor: CustomTheme.primaryColor,
                useMaterial3: false,
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}
