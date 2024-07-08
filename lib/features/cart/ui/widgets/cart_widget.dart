import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/cart/cubit/fetch_cart_cubit.dart';
import 'package:ecommerce_app/features/cart/cubit/update_product_count.dart';
import 'package:ecommerce_app/features/cart/model/cart.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_card.dart';
import 'package:ecommerce_app/features/checkout/ui/screens/check_out_page.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double checkOutAmount;
    return BlocListener<UpdateProductCountCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessState) {
          context.read<FetchCartCubit>().refreshCart();
        }
      },
      child: BlocBuilder<FetchCartCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is CommonSuccessState<List<Cart>>) {
            checkOutAmount = state.item.fold<double>(
                0.0,
                (total, Cart e) =>
                    total +
                    e.quantity!.toDouble() * e.product!.price!.toDouble());
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 16),
                    itemBuilder: (context, index) {
                      return CartCard(
                        cart: state.item[index],
                      );
                    },
                    itemCount: state.item.length,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, -3),
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          "Total Cost: Rs. ${checkOutAmount.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomRoundedButtom(
                        title: "Checkout",
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: CheckoutPage(
                                checkOutAmount: checkOutAmount,
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Container(
              height: 1,
            );
          }
        },
      ),
    );
  }
}
