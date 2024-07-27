import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/data/sharepre.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/ui/banner.dart';
import 'package:flutter_coffee_app/ui/home_best_sellers.dart';
import 'package:flutter_coffee_app/ui/home_offers.dart';
import 'package:flutter_coffee_app/ui/search_container.dart';
import 'package:provider/provider.dart';

import '../ui/cus_card.dart';
import '../ui/head_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  String fullName;
  Home({super.key, this.fullName = ""});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService apiService = ApiService();
  List<ProductModel> productList = [];
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    fetchProducts();

    super.initState();
  }

  void fetchProducts() async {
    try {
      List<ProductModel> products =
          await apiService.getProducts("", "", "", "");
      setState(() {
        productList = products;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return DecoratedBox(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xfffcfcfc), Color(0xfff5eddb)],
        stops: [0.5, 1],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Column(
          children: [
            HeadNav(
              greeting: "Hello, ${appProvider.getUserInformation.fullName}",
            ),
            SearchContainer(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            CusCard(),
            OptionCard(),
            BannerCard(),
            HomeOffers(),
            HomeBestSellers(productList: productList)
          ],
        ),
      ),
    );
  }
}
