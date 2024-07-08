import 'package:ecommerce_app/features/orders/model/order_item.dart';

class FetchedOrder {
  final String? id;
  final List<OrderItem> orderItems;
  final String? fullName;
  final String? address;
  final String? city;
  final String? phone;
  final String? status;
  final int? totalPrice;
  final String? code;
  final DateTime? dateOrdered;
  final int? quantity;

  FetchedOrder({
    required this.id,
    required this.orderItems,
    required this.fullName,
    required this.address,
    required this.city,
    required this.phone,
    required this.status,
    required this.totalPrice,
    required this.code,
    required this.dateOrdered,
    required this.quantity,
  });

  FetchedOrder copyWith({
    String? id,
    List<OrderItem>? orderItems,
    String? fullName,
    String? address,
    String? city,
    String? phone,
    String? status,
    int? totalPrice,
    String? code,
    DateTime? dateOrdered,
    int? quantity,
  }) {
    return FetchedOrder(
      id: id ?? this.id,
      orderItems: orderItems ?? this.orderItems,
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      code: code ?? this.code,
      dateOrdered: dateOrdered ?? this.dateOrdered,
      quantity: quantity ?? this.quantity,
    );
  }

  factory FetchedOrder.fromJson(Map<String, dynamic> json) {
    return FetchedOrder(
      id: json["_id"],
      orderItems: json["orderItems"] == null
          ? []
          : List<OrderItem>.from(
              json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
      fullName: json["full_name"],
      address: json["address"],
      city: json["city"],
      phone: json["phone"],
      status: json["status"],
      totalPrice: json["totalPrice"],
      code: json["code"],
      dateOrdered: DateTime.tryParse(json["dateOrdered"] ?? ""),
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderItems": orderItems.map((x) => x.toJson()).toList(),
        "full_name": fullName,
        "address": address,
        "city": city,
        "phone": phone,
        "status": status,
        "totalPrice": totalPrice,
        "code": code,
        "dateOrdered": dateOrdered?.toIso8601String(),
        "quantity": quantity,
      };
}
