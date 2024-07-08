// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/orders/cubit/fetch_single_order_cubit.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/features/orders/model/single_order.dart';
import 'package:ecommerce_app/features/orders/ui/widgets/order_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersWidget extends StatefulWidget {
  // final SingleOrder singleOrder;
  // final String status;
  const OrdersWidget({
    Key? key,
    // required this.singleOrder,
    // required this.status,
  }) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  void initState() {
    context.read<FetchSinlgeOrderCubit>().fetchSingleOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchSinlgeOrderCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonSuccessState<List<SingleOrder>>) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return OrderCard(
                  singleOrder: state.item[index],
                );
              },
              itemCount: state.item.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
