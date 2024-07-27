import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';
import 'package:flutter_coffee_app/utils/number.dart';
import 'package:provider/provider.dart';

class MenuToppingItem extends StatefulWidget {
  final ToppingModel toppingModel;

  const MenuToppingItem({super.key, required this.toppingModel});

  @override
  State<MenuToppingItem> createState() => _MenuToppingItemState();
}

class _MenuToppingItemState extends State<MenuToppingItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48),
                    child: widget.toppingModel != null
                        ? Image.network(net_img_url + widget.toppingModel.image,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image))
                        : Image.asset(
                            img_deal_url + widget.toppingModel.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image),
                          ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 125,
                //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
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
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.toppingModel.toppingName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  numberFormatter(
                                      double.parse(widget.toppingModel.price)),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
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
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: () {
                          ToppingModel toppingClone =
                              widget.toppingModel.copyWith(qtyCart: 1);
                          appProvider.addCartTopping(toppingClone);
                          showMessage("Thêm sản phẩm thành công");
                        },
                        child: const Icon(
                          Icons.add_outlined,
                          color: Colors.orange,
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
