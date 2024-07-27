import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/models/order_model.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/screen/login/login.dart';

class AppProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  // CART
  final List<ProductModel> _cartProductList = [];
  final List<ToppingModel> _cartToppingList = [];

  void addCartProduct(ProductModel productModel) {
    int index =
        _cartProductList.indexWhere((product) => product.id == productModel.id);
    if (index != -1) {
      int qty = productModel.qtyCart!;
      _cartProductList[index].qtyCart =
          (_cartProductList[index].qtyCart!) + qty;
    } else {
      _cartProductList.add(productModel);
    }
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  void addCartTopping(ToppingModel toppingModel) {
    int index =
        _cartToppingList.indexWhere((product) => product.id == toppingModel.id);
    if (index != -1) {
      int qty = toppingModel.qtyCart!;
      _cartToppingList[index].qtyCart =
          (_cartToppingList[index].qtyCart!) + qty;
    } else {
      _cartToppingList.add(toppingModel);
    }
    notifyListeners();
  }

  List<ToppingModel> get getCartToppingList => _cartToppingList;

  void clearCart() {
    _cartProductList.clear();
    _cartToppingList.clear;
    notifyListeners();
  }

  // FAVOURITE PRODUCT
  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  // USER INFORMATION
  UserModel? _userModel = UserModel.userEmpty();

  UserModel get getUserInformation => _userModel!;

  void fetchUserInfo(int userId) async {
    _userModel = await _apiService.getUserInfo(userId);
    notifyListeners();
  }

  void logOutUser() {
    _userModel = UserModel.userEmpty();
  }

  // TOTAL PRICE
  double totalPrice() {
    double totalPrice = 0.0;
    for (var product in _cartProductList) {
      totalPrice += product.price * product.qtyCart!;
    }
    for (var product in _cartToppingList) {
      totalPrice += double.parse(product.price) * product.qtyCart!;
    }
    return totalPrice;
  }

  double totalPriceWithShippingFee(double shippingFee) {
    double totalPrice = 0.0;
    for (var product in _cartProductList) {
      totalPrice += product.price * product.qtyCart!;
    }
    for (var product in _cartToppingList) {
      totalPrice += double.parse(product.price) * product.qtyCart!;
    }
    return totalPrice + shippingFee;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qtyCart = qty;
    notifyListeners();
  }

  //ORDER OF USER
  List<OrderModel> _userOrderList = [];
  void getUserOrderFromAPI(int id) async {
    _userOrderList = await _apiService.getOrders(id);
  }

  List<OrderModel> get getUserOrderList => _userOrderList;
}
