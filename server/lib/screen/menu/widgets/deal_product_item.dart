import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/utils/number.dart';
import 'package:provider/provider.dart';

class DealProductItem extends StatelessWidget {
  final List<ProductModel> productList;
  const DealProductItem({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    double discount = 0.9;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: productList
            .map(
              (product) => Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Container(
                  width: 172,
                  height: 280,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.network(
                          net_img_url + product.image,
                          width: 175,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  numberFormatter(product.price * discount),
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  numberFormatter(product.price),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.orange)),
                            onPressed: () {
                              ProductModel productClone =
                                  product.copyWith(qtyCart: 1);
                              appProvider.addCartProduct(productClone);
                              showMessage("Thêm sản phẩm thành công");
                            },
                            child: Text(
                              "Mua ngay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
