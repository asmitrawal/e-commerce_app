import 'package:ecommerce_app/features/homepage/model/product.dart';

class Cart {
  final String? id;
  final int? quantity;
  final Product? product;

  Cart({
    required this.id,
    required this.quantity,
    required this.product,
  });

  Cart copyWith({
    String? id,
    int? quantity,
  }) {
    return Cart(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json["_id"] as String, quantity: json["quantity"] as int, product: Product.fromJson(json["product"]));
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "quantity": quantity,
        "product": product!.toJson(),
      };
}
