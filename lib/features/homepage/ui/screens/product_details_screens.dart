// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/features/homepage/cubit/fetch_product_details_cubit.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';
import 'package:ecommerce_app/features/homepage/ui/widgets/product_details_widget.dart';

class ProductDetailsScreens extends StatelessWidget {
  final String productId;
  const ProductDetailsScreens({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FetchProductCubit(repository: context.read<ProductRepository>())
                ..fetchProductDetails(productId: productId),
        ),
        BlocProvider(
          create: (context) =>
              AddToCartCubit(repository: context.read<ProductRepository>()),
        ),
      ],
      child: ProductDetailsWidgets(productId: productId,),
    );
  }
}
