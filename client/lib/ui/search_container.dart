import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/ui/home_best_sellers.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

class SearchContainer extends StatefulWidget {
  const SearchContainer({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  });
  final EdgeInsetsGeometry padding;

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  ApiService apiService = ApiService();
  TextEditingController searchText = TextEditingController();
  List<ProductModel> searchProductList = [];

  @override
  void initState() {
    super.initState();
  }

  void searchProducts() async {
    try {
      if (searchText.text.isNotEmpty) {
        List<ProductModel> products =
            await apiService.getProducts("", "", "", searchText.text);

        setState(() {
          searchProductList = products;
        });
        print(searchProductList);
      } else {
        setState(() {
          searchProductList = [];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) => searchProducts(),
            controller: searchText,
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.search_normal_outline,
                    color: Colors.grey),
                hintText: 'Tìm kiếm sản phẩm...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white),
          ),
          Gap(24),
          if (searchText.text.isNotEmpty && searchProductList.isNotEmpty)
            HomeBestSellers(productList: searchProductList)
          else if (searchText.text.isNotEmpty && searchProductList.isEmpty)
            Text(
              'Danh sách tìm kiếm rỗng',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          Gap(24),
        ],
      ),
    );
  }
}
