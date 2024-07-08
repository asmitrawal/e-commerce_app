import 'package:ecommerce_app/features/orders/cubit/fetch_single_order_cubit.dart';
import 'package:ecommerce_app/features/orders/repository/order_repository.dart';
import 'package:ecommerce_app/features/orders/ui/widgets/order_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreens extends StatelessWidget {
  const OrderScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchSinlgeOrderCubit(repository: context.read<OrderRepository>()),
      child: OrdersWidget(),
    );
  }
}
