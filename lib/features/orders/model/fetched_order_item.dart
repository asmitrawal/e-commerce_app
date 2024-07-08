class FetchedOrderItem {
    FetchedOrderItem({
        required this.id,
        required this.status,
        required this.totalPrice,
        required this.code,
        required this.dateOrdered,
        required this.quantity,
    });

    final String? id;
    final String? status;
    final int? totalPrice;
    final String? code;
    final DateTime? dateOrdered;
    final int? quantity;

    FetchedOrderItem copyWith({
        String? id,
        String? status,
        int? totalPrice,
        String? code,
        DateTime? dateOrdered,
        int? quantity,
    }) {
        return FetchedOrderItem(
            id: id ?? this.id,
            status: status ?? this.status,
            totalPrice: totalPrice ?? this.totalPrice,
            code: code ?? this.code,
            dateOrdered: dateOrdered ?? this.dateOrdered,
            quantity: quantity ?? this.quantity,
        );
    }

    factory FetchedOrderItem.fromJson(Map<String, dynamic> json){ 
        return FetchedOrderItem(
            id: json["_id"],
            status: json["status"],
            totalPrice: json["totalPrice"],
            code: json["code"],
            dateOrdered: DateTime.tryParse(json["dateOrdered"] ?? ""),
            quantity: json["quantity"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "totalPrice": totalPrice,
        "code": code,
        "dateOrdered": dateOrdered?.toIso8601String(),
        "quantity": quantity,
    };

}
