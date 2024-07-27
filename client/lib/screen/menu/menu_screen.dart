import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/style.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/data/productData.dart';
import 'package:flutter_coffee_app/models/category_model.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';
import 'package:flutter_coffee_app/screen/menu/widgets/menu_category_item.dart';
import 'package:flutter_coffee_app/screen/menu/widgets/deal_product_item.dart';
import 'package:flutter_coffee_app/screen/menu/widgets/menu_product_item.dart';
import 'package:flutter_coffee_app/screen/menu/widgets/menu_topping_item.dart';
import 'package:flutter_coffee_app/ui/head_nav.dart';
import 'package:flutter_coffee_app/ui/search_container.dart';

import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

final category1Key = new GlobalKey();
final category2Key = new GlobalKey();
final category3Key = new GlobalKey();
final category4Key = new GlobalKey();
final category5Key = new GlobalKey();
final category6Key = new GlobalKey();
final category7Key = new GlobalKey();
final category8Key = new GlobalKey();

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ApiService api = new ApiService();
  final ScrollController scrollController = ScrollController();

  List<CategoryModel> listCategory = [];
  List<ProductModel> dealProductList = [];
  List<ProductModel> milkTeaProductList = [];
  List<ProductModel> fruitTeaProductList = [];
  List<ProductModel> oolongTeaProductList = [];
  List<ProductModel> snackProductList = [];
  List<ProductModel> mixMilkTeaProductList = [];
  List<ToppingModel> toppingProductList = [];

  //List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    //productList = createDataList(4);
    //listCategory = createCategoryDataList(8);
    fetchCategories();
    fetchDealProducts();
    fetchMilkTeaProducts();
    fetchFruitTeaProducts();
    fetchOolongTeaProducts();
    fetchOolongTeaProducts();
    fetchSnackProducts();
    fetchMixMilkTeaProducts();
    fetchToppingProducts();
  }

  void fetchCategories() async {
    var categories = await api.getCategories();
    setState(() {
      listCategory = categories;
    });
  }

  void fetchDealProducts() async {
    var dealProducts = await api.getProducts("", "", "", "");
    setState(() {
      dealProductList = dealProducts;
    });
  }

  void fetchMilkTeaProducts() async {
    var milkTeaProducts = await api.getProducts("2", "", "", "");
    setState(() {
      milkTeaProductList = milkTeaProducts;
    });
  }

  void fetchFruitTeaProducts() async {
    var fruitTeaProducts = await api.getProducts("7", "", "", "");
    setState(() {
      fruitTeaProductList = fruitTeaProducts;
    });
  }

  void fetchOolongTeaProducts() async {
    var oolongTeaProducts = await api.getProducts("1", "", "", "");
    setState(() {
      oolongTeaProductList = oolongTeaProducts;
    });
  }

  void fetchSnackProducts() async {
    var snackProducts = await api.getProducts("4", "", "", "");
    setState(() {
      snackProductList = snackProducts;
    });
  }

  void fetchMixMilkTeaProducts() async {
    var mixMilkTeaProducts = await api.getProducts("3", "", "", "");
    setState(() {
      mixMilkTeaProductList = mixMilkTeaProducts;
    });
  }

  void fetchToppingProducts() async {
    var toppingProducts = await api.getToppings();
    setState(() {
      toppingProductList = toppingProducts;
    });
  }

  void scrollToCategory(GlobalKey key) {
    Scrollable.ensureVisible(key.currentContext!,
        duration: Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadNav(
                greeting: "Hello, ${appProvider.getUserInformation.fullName}",
              ),
              const SearchContainer(),
              if (listCategory.isNotEmpty)
                MenuCategoryList(
                  scrollToCategory: scrollToCategory,
                  listCategory: listCategory,
                ),
              if (dealProductList.isNotEmpty)
                MenuDealProductList(
                  title: "Deal hời",
                  productList: dealProductList,
                ),
              if (milkTeaProductList.isNotEmpty)
                MenuProductList(
                  title: "Trà sữa",
                  productList: milkTeaProductList,
                  globalKey: category1Key,
                ),
              if (fruitTeaProductList.isNotEmpty)
                MenuProductList(
                  title: "Trà trái cây",
                  productList: fruitTeaProductList,
                  globalKey: category2Key,
                ),
              if (oolongTeaProductList.isNotEmpty)
                MenuProductList(
                  title: "Trà ô long",
                  productList: oolongTeaProductList,
                  globalKey: category3Key,
                ),
              if (snackProductList.isNotEmpty)
                MenuProductList(
                  title: "Trà sữa mix",
                  productList: mixMilkTeaProductList,
                  globalKey: category4Key,
                ),
              if (snackProductList.isNotEmpty)
                MenuProductList(
                  title: "Đồ ăn vặt",
                  productList: snackProductList,
                  globalKey: category5Key,
                ),
              if (toppingProductList.isNotEmpty)
                MenuToppingList(
                  title: "Topping trà sữa",
                  toppingList: toppingProductList,
                  globalKey: category6Key,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCategoryList extends StatelessWidget {
  MenuCategoryList(
      {super.key, required this.listCategory, required this.scrollToCategory});
  final List<CategoryModel> listCategory;
  final void Function(GlobalKey) scrollToCategory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: listCategory.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 92),
              itemBuilder: (context, index) {
                return MenuCategoryItem(
                  categoryModel: listCategory[index],
                  onPressed: () {
                    switch (listCategory[index].name) {
                      case "Trà Sữa":
                        scrollToCategory(category1Key);
                        break;
                      case "Trà Trái Cây":
                        scrollToCategory(category2Key);
                        break;
                      case "Ô Long Sữa":
                        scrollToCategory(category3Key);
                        break;

                      case "Trà Sữa Mix":
                        scrollToCategory(category4Key);
                        break;
                      case "Đồ Ăn Vặt":
                        scrollToCategory(category5Key);
                        break;
                      case "Topping":
                        scrollToCategory(category6Key);
                        break;
                      // Add more cases as needed
                      default:
                        break;
                    }
                  },
                );
              },
            ),
          ),
          const Gap(24),
        ],
      ),
    );
  }
}

class MenuDealProductList extends StatelessWidget {
  final String title;
  final List<ProductModel> productList;
  const MenuDealProductList(
      {super.key, required this.productList, required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTitle(title: title),
          const Gap(12),
          DealProductItem(productList: productList),
          const Gap(24),
        ],
      ),
    );
  }
}

class MenuProductList extends StatelessWidget {
  final String title;
  final List<ProductModel> productList;
  final GlobalKey? globalKey;
  const MenuProductList(
      {super.key,
      required this.productList,
      required this.title,
      this.globalKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTitle(title: title),
            const Gap(12),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return MenuProductItem(
                      productModel: productList[index],
                    );
                  },
                ),
              ],
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}

class MenuToppingList extends StatelessWidget {
  final String title;
  final List<ToppingModel> toppingList;
  final GlobalKey? globalKey;
  const MenuToppingList(
      {super.key,
      required this.toppingList,
      required this.title,
      this.globalKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTitle(title: title),
            const Gap(12),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: toppingList.length,
                  itemBuilder: (context, index) {
                    return MenuToppingItem(
                      toppingModel: toppingList[index],
                    );
                  },
                ),
              ],
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
