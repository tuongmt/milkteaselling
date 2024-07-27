// ignore_for_file: file_names

import 'package:flutter_coffee_app/models/category_model.dart';
import 'package:flutter_coffee_app/models/offer_model.dart';
import 'package:flutter_coffee_app/models/product_model.dart';

createDataList(int amount) {
  List<ProductModel> productList = [];
  for (int i = 1; i <= amount; i++) {
    productList.add(ProductModel(
      id: i,
      name: "Trà sữa chân châu hoàng gia $i",
      price: ((i * 1000) + 18000),
      discount: 0.90,
      // description: "Ngon lam a",
      image: "img_1.png",
      isFavourite: false,
      quantity: 1,
      idCate: '1',
    ));
  }
  return productList;
}

createCategoryDataList(int amount) {
  List<CategoryModel> categoryList = [];
  for (int i = 1; i <= amount; i++) {
    categoryList.add(CategoryModel(
      id: i,
      name: "Trà sữa loại $i",
      image: "img_$i.png",
    ));
  }
  return categoryList;
}

createOfferDataList(int amount) {
  List<OfferModel> offerList = [];
  for (int i = 1; i <= amount; i++) {
    offerList.add(OfferModel(
      id: i.toString(),
      title: "Lễ hội mùa hè Trà sữa - Mua 1 tặng 1",
      time: "${i + 1}/${i}",
      image: "image.png",
    ));
  }
  return offerList;
}
