// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/orders/model/single_order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecommerce_app/common/custom_theme.dart';

class OrderCard extends StatefulWidget {
  final SingleOrder singleOrder;
  const OrderCard({
    Key? key,
    required this.singleOrder,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    imageUrl: "${widget.singleOrder.product.image}",
                    imageBuilder: (context, imageProvider) {
                      return Image.network(
                        "${widget.singleOrder.product.image}",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      );
                    },
                    placeholder: (context, url) {
                      return Container(
                        height: 70,
                        width: 70,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        height: 70,
                        width: 70,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.singleOrder.product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Rs. ${widget.singleOrder.product.price!}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: CustomTheme.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${widget.singleOrder.status}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                          height: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
