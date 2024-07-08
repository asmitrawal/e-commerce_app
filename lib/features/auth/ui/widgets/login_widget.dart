import 'package:ecommerce_app/features/auth/repo/user_repository.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/features/auth/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/cubit/social_login_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/screens/signup_page.dart';
import 'package:ecommerce_app/features/dashboard/ui/screens/dashboard_screens.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: AppBar(backgroundColor: CustomTheme.primaryColor),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.horizontalPadding,
          ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<loginCubit, CommonState>(
                listener: (context, state) {
                  if (state is CommonLoadingState) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                  if (state is CommonSuccessState) {
                    ElegantNotification.success(
                            description: Text("Login Successful!"))
                        .show(context);
                    context.read<UserRepository>().initialize();
                    Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: DashboardScreens(),
                        type: PageTransitionType.fade,
                      ),
                      (route) => false,
                    );
                  }
                  if (state is CommonErrorState) {
                    ElegantNotification.error(description: Text(state.message))
                        .show(context);
                  }
                },
              ),
              BlocListener<SocialLoginCubit, CommonState>(
                listener: (context, state) {
                  if (state is CommonLoadingState) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                  if (state is CommonSuccessState) {
                    ElegantNotification.success(
                            description: Text("Login Successful!"))
                        .show(context);
                    Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: DashboardScreens(),
                        type: PageTransitionType.fade,
                      ),
                      (route) => false,
                    );
                  }
                  if (state is CommonErrorState) {
                    ElegantNotification.error(description: Text(state.message))
                        .show(context);
                  }
                },
              ),
            ],
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    fieldName: "email",
                    label: "Email Address",
                    hintText: "Enter Email Address",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Email field cannot be empty";
                      }
                      final _isvalid = EmailValidator.validate(val);
                      if (_isvalid) {
                        return null;
                      } else {
                        return "Enter valid email address";
                      }
                    },
                  ),
                  CustomTextField(
                    label: "Password",
                    fieldName: "password",
                    hintText: "Enter Password",
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Password field cannot be empty";
                      } else if (val.length < 4) {
                        return "Password field must be at least 4 character long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomRoundedButtom(
                    title: "LOGIN",
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        await context.read<loginCubit>().login(
                              email: _formKey.currentState!.value["email"],
                              password:
                                  _formKey.currentState!.value["password"],
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<SocialLoginCubit>().facebookLogin();
                        },
                        icon: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue.shade500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<SocialLoginCubit>().googleLogin();
                        },
                        icon: Icon(FontAwesomeIcons.google,
                            color: Colors.red.shade400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Don't have account?",
                      style: _textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: " Sign Up",
                          style: _textTheme.bodyMedium!.copyWith(
                            color: CustomTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: SignupPages(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
