import 'package:ecommerce_app/features/orders/model/order_item.dart';

class CustomOrder {
  final String? id;
  final List<OrderItem>? orderItems;
  final String? status;
  final int? totalPrice;
  final String? code;
  final String? dateOrdered;
  final int? quantity;

  CustomOrder({
    required this.id,
    required this.orderItems,
    required this.status,
    required this.totalPrice,
    required this.code,
    required this.dateOrdered,
    required this.quantity,
  });

  CustomOrder copyWith({
    final String? id,
    final List<OrderItem>? orderItems,
    final String? status,
    final int? totalPrice,
    final String? code,
    final String? dateOrdered,
    final int? quantity,
  }) {
    return CustomOrder(
      id: id ?? this.id,
      orderItems: orderItems ?? this.orderItems,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      code: code ?? this.code,
      dateOrdered: dateOrdered ?? this.dateOrdered,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CustomOrder.fromJson(Map<String, dynamic> json) {
    return CustomOrder(
        id: json["_id"],
        orderItems: List.from(json["orderItems"])
            .map((e) => OrderItem.fromJson(e))
            .toList(),
        status: json["status"],
        totalPrice: json["totalPrice"],
        code: json["code"],
        dateOrdered: json["dateOrdered"],
        quantity: json["quantity"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id, //or "_id": this.id
      "orderItems": this.orderItems?.map((e) => e.toJson()).toList(),
      "status": this.status,
      "totalPrice": this.totalPrice,
      "code": this.code,
      "dateOrdered": this.dateOrdered,
      "quantity": this.quantity,
    };
  }
}
