import 'dart:convert';

import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/product_order_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';
import 'dart:convert';

class OrderDetailModel {
    int id;
    int orderId;
    int productId;
    int quantity;
    int totalPrice;
    IdProductData idProductData;
    List<Topping> toppings;
    String idOrderData;

    OrderDetailModel({
        required this.id,
        required this.orderId,
        required this.productId,
        required this.quantity,
        required this.totalPrice,
        required this.idProductData,
        required this.toppings,
        required this.idOrderData,
    });

    factory OrderDetailModel.fromRawJson(String str) => OrderDetailModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        idProductData: IdProductData.fromJson(json["idProductData"]),
        toppings: List<Topping>.from(json["Toppings"].map((x) => Topping.fromJson(x))),
        idOrderData: json["idOrderData"]["order_status"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "total_price": totalPrice,
        "idProductData": idProductData.toJson(),
        "Toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
        "idOrderData": idOrderData,
    };
    String toJson() => jsonEncode(toMap());
}



class IdProductData {
    int id;
    String name;
    String image;
    String price;

    IdProductData({
        required this.id,
        required this.name,
        required this.image,
        required this.price,
    });

    factory IdProductData.fromRawJson(String str) => IdProductData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory IdProductData.fromJson(Map<String, dynamic> json) => IdProductData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
    };
    String toJson() => jsonEncode(toMap());
}

class Topping {
    int toppingId;
    int orderId;

    Topping({
        required this.toppingId,
        required this.orderId,
    });

    factory Topping.fromRawJson(String str) => Topping.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        toppingId: json["ToppingID"],
        orderId: json["order_id"],
    );

    Map<String, dynamic> toMap() => {
        "ToppingID": toppingId,
        "order_id": orderId,
    };
    String toJson() => jsonEncode(toMap());
}
