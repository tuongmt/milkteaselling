import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/utils/number.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                net_img_url + widget.productModel.image,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 450,
              ),
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productModel.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Gap(8),
                Text(
                  numberFormatter(widget.productModel.price),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Gap(8),
                Text(
                    'Uống một miếng, thơm ngon ngất ngây\nĂn một miếng, giòn thơm bơ béo vỏ bánh, giòn tan trong miệng',
                    style: TextStyle(
                      fontSize: 20,
                    ))
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        if (qty > 1) {
                          setState(() {
                            qty--;
                          });
                        }
                      },
                      padding: EdgeInsets.zero,
                      child: const CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.remove, size: 18),
                      ),
                    ),
                    Gap(10),
                    Text(
                      qty.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Gap(10),
                    CupertinoButton(
                      onPressed: () {
                        setState(() {
                          qty++;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: const CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                      ),
                      onPressed: () {
                        appProvider.addCartProduct(widget.productModel);
                        appProvider.updateQty(widget.productModel, qty);
                        Navigator.pop(context);
                      },
                      child: Text(
                          numberFormatter(widget.productModel.price * qty))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
