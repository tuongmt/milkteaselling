import 'dart:convert';

OfferModel categoryModelFromJson(String str) =>
    OfferModel.fromJson(json.decode(str));

String categoryModeltoJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  String id;
  String title;
  String image;
  String time;

  OfferModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.time});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "time": time,
      };
}
