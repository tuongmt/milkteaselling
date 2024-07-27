import 'dart:convert';

class ProductOrderModel {
  int productId;
  int quantity;
  int totalPrice;

  ProductOrderModel({
    required this.productId,
    required this.quantity,
    required this.totalPrice,
  });

  factory ProductOrderModel.fromRawJson(String str) =>
      ProductOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) =>
      ProductOrderModel(
        productId: json["product_id"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
        "total_price": totalPrice,
      };
  // String toJson() {
  //   return jsonEncode(toMap());
  // }
    Map<String, dynamic> toJson() {
    return toMap();
  }
}
