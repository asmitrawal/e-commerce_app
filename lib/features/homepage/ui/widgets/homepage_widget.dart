import 'package:ecommerce_app/common/cards/product_card.dart';
import 'package:ecommerce_app/common/cubit/common_state.dart';
import 'package:ecommerce_app/features/homepage/cubit/fetch_all_products_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllProductsCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonErrorState) {
          return Center(
            child: Text(state.message, style: TextStyle(fontSize: 10),),
          );
        } else if (state is CommonSuccessState<List<Product>>) {
          return Container(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return ProductCards(product: state.item[index],);
              },
              itemCount: 10,
            ),
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
