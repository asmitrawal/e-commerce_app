import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String profile;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.profile,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? profile,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        profile: profile ?? this.profile,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        email: json["email"]?? "",
        phone: json["phone"] ?? "",
        address: json["address"] ?? "",
        profile: json["profile"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "profile": profile,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"],
      address: map["address"],
      email: map["email"],
      name: map["name"],
      phone: map["phone"],
      profile: map["profile"],
    );
  }
}
