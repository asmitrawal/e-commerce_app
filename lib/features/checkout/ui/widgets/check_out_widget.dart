// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_app/features/orders/cubit/create_order_cubit.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/features/checkout/ui/widgets/order_confirm_dialog.dart';

class CheckoutWidgets extends StatefulWidget {
  final double checkOutAmount;
  const CheckoutWidgets({
    Key? key,
    required this.checkOutAmount,
  }) : super(key: key);

  @override
  State<CheckoutWidgets> createState() => _CheckoutWidgetsState();
}

class _CheckoutWidgetsState extends State<CheckoutWidgets> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CustomTextField(
                    label: "Full Name",
                    hintText: "Full Name",
                    fieldName: "full_name",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Full Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: "Phone Number",
                    hintText: "Phone Number",
                    fieldName: "phone_number",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Phone Number cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: "City",
                    hintText: "City",
                    fieldName: "city",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "City cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextField(
                    label: "Address",
                    hintText: "Address",
                    fieldName: "address",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Address cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomRoundedButtom(
                    title: "Confirm Order",
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        KhaltiScope.of(context).pay(
                          preferences: [PaymentPreference.khalti],
                          config: PaymentConfig(
                            // amount: (widget.checkOutAmount * 100).toInt(),
                            amount: 1000,
                            productIdentity: "testProductId",
                            productName: "testProductName",
                          ),
                          onSuccess: (success) {
                            context.read<CreateOrderCubit>().createOrder(
                                address:
                                    _formKey.currentState!.value["address"],
                                city: _formKey.currentState!.value["city"],
                                phone: _formKey
                                    .currentState!.value["phone_number"],
                                fullName:
                                    _formKey.currentState!.value["full_name"]);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return OrderConfirmDialog();
                              },
                            );
                          },
                          onFailure: (err) {
                            ElegantNotification.error(
                                    description: Text(err.message))
                                .show(context);
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
