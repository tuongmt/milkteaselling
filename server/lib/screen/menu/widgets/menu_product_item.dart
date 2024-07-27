import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/screen/menu/widgets/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/utils/number.dart';

class MenuProductItem extends StatefulWidget {
  final ProductModel productModel;
  const MenuProductItem({super.key, required this.productModel});

  @override
  State<MenuProductItem> createState() => _MenuProductItemState();
}

class _MenuProductItemState extends State<MenuProductItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return GestureDetector(
      onTap: () {
        Routes.push(
            widget: ProductDetailScreen(productModel: widget.productModel),
            context: context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 125,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  child: widget.productModel != null
                      ? Image.network(net_img_url + widget.productModel.image,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image))
                      : Image.asset(
                          img_deal_url + widget.productModel.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image),
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 125,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Container(
                              width: 175,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.productModel.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    numberFormatter(widget.productModel.price),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            color: Colors.orange[300],
                            icon: isFavorite
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border_outlined),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            ProductModel productClone =
                                widget.productModel.copyWith(qtyCart: 1);
                            appProvider.addCartProduct(productClone);
                            showMessage('Thêm sản phẩm thành công');
                          },
                          child: const Icon(
                            Icons.add_outlined,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
