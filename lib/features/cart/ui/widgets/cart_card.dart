// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/cart/cubit/update_product_count.dart';
import 'package:ecommerce_app/features/cart/model/cart.dart';

class CartCard extends StatefulWidget {
  final Cart cart;
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late int _quantity;
  @override
  void initState() {
    _quantity = widget.cart.quantity!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProductCountCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoadingState) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
        if (state is CommonErrorState) {
          ElegantNotification.error(
                  description: Text("unable to change quantity"))
              .show(context);
        }

        if (state is CommonSuccessState<Cart> &&
            state.item.id == widget.cart.id) {
          setState(() {
            _quantity = state.item.quantity!;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
          left: CustomTheme.horizontalPadding,
          right: CustomTheme.horizontalPadding,
        ),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: "${widget.cart.product!.image}",
                      imageBuilder: (context, imageProvider) {
                        return Image.network(
                          widget.cart.product!.image ?? "",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          width: 60,
                          height: 60,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          width: 60,
                          height: 60,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.cart.product!.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Rs. ${widget.cart.product!.price}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 10.0,
                        onPressed: () {
                          if (_quantity > 1) {
                            final tempQuantity = _quantity;
                            // setState(() {
                            //   _quantity = _quantity - 1;
                            // });
                            context
                                .read<UpdateProductCountCubit>()
                                .updateProductCount(
                                    cartId: widget.cart.id ?? "",
                                    quantity: tempQuantity - 1);
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 16,
                          color: CustomTheme.primaryColor,
                        ),
                      ),
                      Text(
                        '${_quantity}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        splashRadius: 10.0,
                        onPressed: () {
                          final tempQuantity = _quantity;
                          // setState(() {
                          //   _quantity = _quantity + 1;
                          // });
                          context
                              .read<UpdateProductCountCubit>()
                              .updateProductCount(
                                  cartId: widget.cart.id ?? "",
                                  quantity: tempQuantity + 1);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 16,
                          color: CustomTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
