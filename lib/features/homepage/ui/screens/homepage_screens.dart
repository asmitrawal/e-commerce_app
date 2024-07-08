import 'package:ecommerce_app/features/homepage/cubit/fetch_all_products_cubit.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';
import 'package:ecommerce_app/features/homepage/ui/widgets/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageScreens extends StatelessWidget {
  const HomepageScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllProductsCubit(
        repository: context.read<ProductRepository>(),
      )..fetchAllProducts(),
      child: HomepageWidget(),
    );
  }
}
