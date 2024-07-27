import 'dart:convert';

import 'package:flutter_coffee_app/models/product_order_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';

enum Payment {
  cod,
  atm;

  static Payment fromString(String s) => switch (s) {
        "cod" => cod,
        "atm" => atm,
        _ => cod,
      };

  String toJson() => switch (this) {
        cod => "cod",
        atm => "atm",
      };
}

enum OrderStatus {
  Waiting,
  Cooking,
  Shipping,
  Done;

  static OrderStatus fromString(String s) => switch (s) {
        "Waiting" => Waiting,
        "Cooking" => Cooking,
        "Shipping" => Shipping,
        "Done" => Done,
        _ => Waiting,
      };

  String toJson() => switch (this) {
        Waiting => "Đang chờ để duyệt",
        Cooking => "Đang pha chế",
        Shipping => "Đang giao hàng",
        Done => "Hoàn thành"
      };
  String get(OrderStatus status) => switch (status) {
        Waiting => "Đang chờ để duyệt",
        Cooking => "Đang pha chế",
        Shipping => "Đang giao hàng",
        Done => "Hoàn thành"
      };
}

class OrderModel {
  int? id;
  int orderIdUser;
  String receiver;
  String orderStatus;
  String receivingPoint;
  String phoneNumber;
  String totalValue;
  IdProductData? idProductData;
  String note;
  String payment;
  List<ProductOrderModel> productList;
  List<ToppingModel> toppings;

  OrderModel({
    this.id,
    required this.receiver,
    required this.orderStatus,
    required this.receivingPoint,
    required this.phoneNumber,
    required this.totalValue,
    this.idProductData,
    required this.note,
    required this.payment,
    required this.orderIdUser,
    required this.productList,
    required this.toppings,
  });

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        receiver: json["receiver"],
        orderStatus: json["order_status"],
        receivingPoint: json["receiving_point"],
        phoneNumber: json["phoneNumber"],
        totalValue: json["total_value"],
        idProductData: json["productList"] != null
            ? IdProductData.fromJson(json["idProductData"])
            : IdProductData(id: 0, name: "", image: "", price: ""),
        note: json["note"],
        payment: json["payment"],
        orderIdUser: json["order_idUser"],
        productList: json["productList"] != null
            ? List<ProductOrderModel>.from(
                json["productList"].map((x) => ProductOrderModel.fromJson(x)))
            : List<ProductOrderModel>.empty(),
        toppings: json["productList"] != null
            ? List<ToppingModel>.from(
                json["toppings"].map((x) => ToppingModel.fromJson(x)))
            : List<ToppingModel>.empty(),
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "receiver": receiver,
      "order_status": orderStatus,
      "receiving_point": receivingPoint,
      "phoneNumber": phoneNumber,
      "total_value": totalValue,
      "idProductData": idProductData?.toJson(),
      "note": note,
      "payment": payment,
      "order_idUser": orderIdUser,
      //"productList": productList.map((x) => x.toJson()).toList(),
      "productList": List<ProductOrderModel>.from(productList),

      //List<dynamic>.from(productList.map((x) => x.toJson())),
      "toppings": List<dynamic>.from(toppings.map((x) => x.toJson())),
    };
  }

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

  factory IdProductData.fromRawJson(String str) =>
      IdProductData.fromJson(json.decode(str));

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
