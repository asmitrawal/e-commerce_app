// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String? id;
  final String? name;
  final String? image;
  final String? brand;
  final String? description;
  final int? price;
  final List<String> catagories;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.brand,
    this.description,
    required this.price,
    required this.catagories,
  });

  Product copyWith({
    String? id,
    String? name,
    String? image,
    String? brand,
    String? description,
    int? price,
    List<String>? catagories,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      catagories: catagories ?? this.catagories,
      description: description ?? this.description,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      image: json["image"],
      brand: json["brand"],
      price: json["price"],
      description: json["description"],
      catagories: json["catagories"] == null
          ? []
          : List<String>.from(json["catagories"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "brand": brand,
        "price": price,
        "description": description,
        "catagories": catagories.map((x) => x).toList(),
      };
}
