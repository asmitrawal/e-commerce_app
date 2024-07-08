import 'package:ecommerce_app/features/homepage/model/product.dart';

class OrderItem {
  final String? id;
  final int? quantity;
  final Product? product;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.product,
  });

  OrderItem copyWith({
    String? id,
    int? quantity,
    Product? product,
  }) {
    return OrderItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["_id"],
      quantity: json["quantity"],
      product: Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "quantity": quantity,
        "product": product?.toJson(),
      };
}
