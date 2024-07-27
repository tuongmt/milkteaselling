//api nay cua tuong nha hihi
import 'dart:convert';
import 'package:flutter_coffee_app/models/category_model.dart';
import 'package:flutter_coffee_app/models/order_detail_model.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';
import 'package:flutter_coffee_app/models/order_model.dart';
import 'package:flutter_coffee_app/models/product_order_model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService instance = ApiService();
  var baseUrl = 'http://10.21.39.155:8080/api';

  Map<String, String> headers() {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
  }

  Future<UserModel> signUp(UserModel user) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/create-new-user'),
        headers: headers(),
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        dynamic checkErrorCode = responseData['errCode'];
        if (checkErrorCode != 0) {
          throw Exception('Failed');
        }
        print('Sign up success');
        return UserModel.fromJson(responseData["data"]);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<UserModel> logIn(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: headers(),
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        dynamic checkErrorCode = responseData['errCode'];
        if (checkErrorCode != 0) {
          throw Exception(responseData["message"]);
        }
        print('Success');
        return UserModel.fromJson(responseData["user"]);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<UserModel> getUserInfo(int userId) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-users?id=$userId'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        dynamic checkErrorCode = responseData['errCode'];
        if (checkErrorCode != 0) {
          throw Exception(responseData["message"]);
        }
        print('Success');
        return UserModel.fromJson(responseData["users"]);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      var response = await http.post(Uri.parse('$baseUrl/edit-user'),
          headers: headers(), body: user.toJson());

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        dynamic checkErrorCode = responseData['errCode'];
        if (checkErrorCode != 0) {
          throw Exception(responseData["message"]);
        }
        print('Success');
        return UserModel.fromJson(responseData["data"]);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<ProductModel>> getProducts(String? cateId, String? price,
      String? orderBy, String? productName) async {
    try {
      var response;
      response = await http.get(
        Uri.parse(
            '$baseUrl/get-all-products/?id=ALL&idCate=$cateId&price=$price&orderBy=price-asc&productName=$productName'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        List<dynamic> data = responseData['products'];
        print('Success');
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<ProductModel> getProduct(String? id) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-products?id=$id'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        dynamic data = responseData['products'][0];
        print('Success');
        return ProductModel.fromJson(data);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> createProduct(ProductModel product) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/create-new-products'),
        headers: headers(),
        body: product.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/edit-products/'),
        headers: headers(),
        body: product.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      var response = await http.delete(
        Uri.parse('$baseUrl/delete-products'),
        headers: headers(),
        body: jsonEncode(<String, dynamic>{
          'id': id,
        }),
      );

      if (response.statusCode == 200) {
        print('Success');
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<CategoryModel> createCategory(CategoryModel category) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/create-new-categories'),
        headers: headers(),
        body: category.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
        var jsonBody = jsonDecode(response.body)["data"];
        return CategoryModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/edit-categories/'),
        headers: headers(),
        body: category.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
        var jsonBody = jsonDecode(response.body);
        return CategoryModel.fromJson(jsonBody["data"]);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<CategoryModel> getCategory(String id) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-categories?id=$id'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        dynamic data = responseData['categories'];
        print('Success');
        return CategoryModel.fromJson(data);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-categories/?id=ALL'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        List<dynamic> data = responseData['categories'];
        print('Success');
        return data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<ToppingModel> createTopping(ToppingModel topping) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/create-new-topping'),
        headers: headers(),
        body: topping.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
        var jsonBody = jsonDecode(response.body)["data"];
        return ToppingModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<ToppingModel> updateTopping(ToppingModel topping) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/edit-topping/'),
        headers: headers(),
        body: topping.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
        var jsonBody = jsonDecode(response.body);
        return ToppingModel.fromJson(jsonBody["data"]);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<ToppingModel> getTopping(String categoryId) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-toppings?id=$categoryId'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        dynamic data = responseData['data'];
        print('Success');
        return ToppingModel.fromJson(data);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<ToppingModel>> getToppings() async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-toppings/?id=ALL'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print(responseData);
        List<dynamic> data = responseData['data'];
        print('Success');
        return data.map((e) => ToppingModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/create-new-orders'),
        headers: headers(),
        body: order.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
        var jsonBody = jsonDecode(response.body)["data"];
        return OrderModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<OrderModel> updateOrder(OrderModel order) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/edit-orders/'),
        headers: headers(),
        body: order.toJson(),
      );

      if (response.statusCode == 200) {
        print('Success');
        var jsonBody = jsonDecode(response.body);
        return OrderModel.fromJson(jsonBody["data"]);
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrders(int userId) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-orders?id=$userId'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        List<dynamic> data = responseData['data'];
        print('Success');
        var result = data.map((e) => OrderModel.fromJson(e));
        return result.toList();
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<OrderDetailModel>> getOrderDetail(int idOrder) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/get-all-Orderdetail?id=$idOrder'),
        headers: headers(),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
       // print(responseData);
        List<dynamic> data = responseData['Oderdetail'];
        print(ProductModel.fromJson(data[0]["idProductData"]));
        print('Success');
        var result = data.map((e) => OrderDetailModel.fromJson(e));
        return result.toList();
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
