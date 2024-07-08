// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:ecommerce_app/features/homepage/cubit/fetch_product_details_cubit.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/homepage/model/product.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProductDetailsWidgets extends StatelessWidget {
  final String productId;

  ProductDetailsWidgets({
    required this.productId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
      ),
      body: BlocListener<AddToCartCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoadingState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }

          if (state is CommonSuccessState) {
            ElegantNotification.success(
                    description: Text("Product added to cart successfully"))
                .show(context);
          } else if (state is CommonErrorState) {
            ElegantNotification.error(description: Text(state.message))
                .show(context);
          }
        },
        child: BlocBuilder<FetchProductCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoadingState) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            if (state is CommonErrorState) {
              return Center(
                child: Text("${state.message}"),
              );
            }
            if (state is CommonSuccessState<Product>) {
              return Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: state.item.image ?? "",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: MediaQuery.of(context).size.height * .35,
                        width: double.infinity,
                        child: Image.network(
                          state.item.image ?? "",
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      return Container(
                        height: MediaQuery.of(context).size.height * .35,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          "image URL invalid",
                          style: TextStyle(fontSize: 10),
                        )),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        height: MediaQuery.of(context).size.height * .35,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          "image URL invalid",
                          style: TextStyle(fontSize: 10),
                        )),
                      );
                    },
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 40, right: 14, left: 14),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          height: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.item.brand}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        '${state.item.name}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Rs. ${state.item.price}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  '${state.item.description}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: CustomTheme.gray,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: CustomTheme.gray,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BlocSelector<FetchProductCubit, CommonState, bool>(
        selector: (state) {
          if (state is CommonSuccessState) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state == true) {
            return Container(
              height: 70,
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: CustomRoundedButtom(
                title: "+ Add to Cart",
                onPressed: () {
                  context
                      .read<AddToCartCubit>()
                      .addToCart(productId: productId);
                },
              ),
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
