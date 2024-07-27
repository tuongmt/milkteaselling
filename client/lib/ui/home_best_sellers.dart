import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/config/style.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/data/productData.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/utils/number.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeBestSellers extends StatefulWidget {
  final List<ProductModel> productList;
  final bool showTitle;
  const HomeBestSellers(
      {super.key, required this.productList, this.showTitle = true});

  @override
  State<HomeBestSellers> createState() => _HomeBestSellersState();
}

class _HomeBestSellersState extends State<HomeBestSellers> {
  int qty = 1;
  // List<ProductModel> productList = [];
  // @override
  // void initState() {
  //   productList = createDataList(4);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // widget.showTitle
          //     ?  MyTitle(
          //         title: 'Best Sellers',
          //       )
          //     : null,
          const Gap(8),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
                mainAxisExtent: 275),
            itemCount: widget.productList.length,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              ProductModel singleProduct = widget.productList[index];
              return BestSellersItem(
                product: singleProduct,
                onTap: () {
                  ProductModel productModel =
                      singleProduct.copyWith(qtyCart: qty);
                  print(productModel);
                  appProvider.addCartProduct(productModel);
                  showMessage('Thêm thành công');
                },
              );
            },
          )
        ]);
  }
}

class BestSellersItem extends StatelessWidget {
  final ProductModel product;
  final void Function() onTap;
  const BestSellersItem(
      {super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.grey,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Image.network(
                  net_img_url + product.image,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    child: const Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(4),
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      numberFormatter(product.price),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
