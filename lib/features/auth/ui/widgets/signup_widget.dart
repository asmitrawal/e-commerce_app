import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/features/auth/cubit/sign_up_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';

class SignupWidgets extends StatefulWidget {
  const SignupWidgets({Key? key}) : super(key: key);

  @override
  State<SignupWidgets> createState() => _SignupWidgetsState();
}

class _SignupWidgetsState extends State<SignupWidgets> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: AppBar(backgroundColor: CustomTheme.primaryColor),
      body: BlocListener<SignUpCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoadingState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is CommonSuccessState<String>) {
            ElegantNotification.success(description: Text(state.item))
                .show(context);
            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(child: LoginPage(), type: PageTransitionType.fade),
              (route) => false,
            );
          }
          if (state is CommonErrorState) {
            ElegantNotification.error(description: Text(state.message))
                .show(context);
          }
        },
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Full name",
                    fieldName: "full_name",
                    hintText: "Enter Full Name",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Full Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: "Phone Number",
                    hintText: "Enter Phone Number",
                    fieldName: "phone_number",
                    textInputType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Phone Number cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: "Address",
                    hintText: "Enter Address",
                    fieldName: "address",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Address cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: "Email Address",
                    hintText: "Enter Email Address",
                    fieldName: "email",
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
                    hintText: "Enter Password",
                    fieldName: "password",
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
                  CustomTextField(
                    label: "Confirm Password",
                    hintText: "Enter Confirm Password",
                    fieldName: "confirm_password",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Confirm Password field cannot be empty";
                      } else if (val.length < 4) {
                        return "Password field must be at least 4 character long";
                      } else if (val !=
                          _formKey.currentState!.instantValue["password"]) {
                        return "Password doesnot matched";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                  ),
                  CustomRoundedButtom(
                    title: "SIGNUP",
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        print(_formKey.currentState?.value);
                        context.read<SignUpCubit>().signUp(
                            name: _formKey.currentState!.value["full_name"],
                            email: _formKey.currentState!.value["email"],
                            password: _formKey.currentState!.value["password"],
                            phone: _formKey.currentState!.value["phone_number"],
                            address: _formKey.currentState!.value["address"]);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Already have account?",
                      style: _textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: " Sign In",
                          style: _textTheme.bodyMedium!.copyWith(
                            color: CustomTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pop();
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
