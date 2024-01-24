import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String? name;
  String? image;
  double? price;
  int? qty;

  Product({
    this.id,
    this.qty=1,
    this.name,
    this.image,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        qty: json['quantity'],
        name: json["name"],
        image: json["image"],
        price: json["price"]?.toDouble(),
      );

  Map<String, Object> toJson() => {
        "id": id!,
        "quantity": qty!,
        "name": name!,
        "image": image!,
        "price": price!,
      };
}
