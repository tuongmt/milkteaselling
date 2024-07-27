import 'dart:convert';

class ToppingModel {
  int id;
  int categoryId;
  String toppingName;
  String price;
  String image;
  int? qtyCart;

  ToppingModel(
      {required this.id,
      required this.categoryId,
      required this.toppingName,
      required this.price,
      required this.image,
      this.qtyCart});

  factory ToppingModel.fromRawJson(String str) =>
      ToppingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ToppingModel.fromJson(Map<String, dynamic> json) => ToppingModel(
        id: json["id"],
        categoryId: json["CategoryID"],
        toppingName: json["ToppingName"],
        price: json["Price"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "CategoryID": categoryId,
        "ToppingName": toppingName,
        "Price": price,
        "image": image,
      };
  String toJson() => jsonEncode(toMap());

  ToppingModel copyWith({
    int? qtyCart,
  }) =>
      ToppingModel(
          id: id,
          toppingName: toppingName,
          price: price,
          categoryId: categoryId,
          image: image,
          qtyCart: qtyCart ?? this.qtyCart);
}
