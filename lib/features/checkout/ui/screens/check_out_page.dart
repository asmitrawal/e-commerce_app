// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/orders/cubit/create_order_cubit.dart';
import 'package:ecommerce_app/features/orders/repository/order_repository.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:ecommerce_app/features/checkout/ui/widgets/check_out_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  final double checkOutAmount;
  const CheckoutPage({
    Key? key,
    required this.checkOutAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateOrderCubit(repository: context.read<OrderRepository>()),
      child: CheckoutWidgets(
        checkOutAmount: checkOutAmount,
      ),
    );
  }
}
