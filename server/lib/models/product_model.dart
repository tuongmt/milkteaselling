import 'dart:convert';

ProductModel productModelFromJson(Map<String, dynamic> json) =>
    ProductModel.fromJson(json);

class ProductModel {
  int id;
  String name;
  double price;
  double? discount;
  // String description;
  String image;
  bool isFavourite;
  String idCate;
  String? idDiscount;
  String? idSale;
  int? quantity;
  int? qtyCart;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      this.discount,
      //  required this.description,
      required this.image,
      required this.idCate,
      required this.isFavourite,
      this.quantity,
      this.qtyCart,
      });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: (json["price"] is String)
            ? double.parse(json["price"])
            : json["price"].toDouble(),
        discount: json["discount"] != null
            ? (json["discount"] is String)
                ? double.parse(json["discount"])
                : json["discount"].toDouble()
            : null,
        //description: json["description"],
        image: json["image"],
        isFavourite: false,
        idCate: json["idCate"].toString(),
        quantity: json["quantity"] != null
            ? (json["quantity"] is String)
                ? int.parse(json["quantity"])
                : json["quantity"]
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "discount": discount,
        // "description": description,
        "image": image,
        "isFavourite": isFavourite,
        "idCate": idCate,
        "quantity": quantity,
      };
  String toJson() => json.encode(this.toMap());

  ProductModel copyWith({
    int? qtyCart,
  }) =>
      ProductModel(
          id: id,
          name: name,
          price: price,
          discount: discount,
          //  description: description,
          image: image,
          isFavourite: isFavourite,
          idCate: idCate,
          qtyCart: qtyCart ?? this.qtyCart);
}
