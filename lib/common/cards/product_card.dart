import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/homepage/model/product.dart';
import 'package:ecommerce_app/features/homepage/ui/screens/product_details_screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProductCards extends StatelessWidget {
  final Product product;

  const ProductCards({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: CustomTheme.horizontalPadding),
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: ProductDetailsScreens(
                productId: "${product.id}",
              ),
              type: PageTransitionType.fade,
            ),
          );
        },
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? "",
                      imageBuilder: (context, imageProvider) {
                        return Image.network(
                          product.image ?? "",
                          height: 220,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          height: 220,
                          child: Center(
                              child: CircularProgressIndicator.adaptive()),
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          height: 220,
                          child: Center(
                              child: CircularProgressIndicator.adaptive()),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, bottom: 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${product.name}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "${product.brand}",
                    style: TextStyle(
                      fontSize: 12,
                      color: CustomTheme.darkGrayColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rs. ${product.price}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
