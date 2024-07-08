// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/homepage/model/product.dart';

class SingleOrder {
  final String status;
  final Product product;

  SingleOrder({
    required this.status,
    required this.product,
  });
}
