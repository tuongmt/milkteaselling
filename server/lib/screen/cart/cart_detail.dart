import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/data/sharepre.dart';
import 'package:flutter_coffee_app/main.dart';
import 'package:flutter_coffee_app/models/order_model.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/product_order_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/screen/cart/cart_success.dart';
import 'package:flutter_coffee_app/screen/cart/cart_voucher.dart';
import 'package:flutter_coffee_app/screen/cart/payment_option.dart';
import 'package:flutter_coffee_app/screen/menu/menu_screen.dart';
import 'package:flutter_coffee_app/utils/number.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartDetail extends StatefulWidget {
  final int selectedVoucher;

  const CartDetail({super.key, required this.selectedVoucher});

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    UserModel userModel = appProvider.getUserInformation;
    List<ProductModel> cartProductList = appProvider.getCartProductList;
    List<ToppingModel> cartToppingList = appProvider.getCartToppingList;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Giỏ hàng",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {
                    //appProvider.clearCart();
                    _showClearConfirmationDialog(context);
                  },
                  child: Text('Xóa tất cả')),
            )
          ],
          centerTitle: true,
        ),
        body: appProvider.getCartProductList.isNotEmpty
            ? SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 234, 229, 229)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (userModel.fullName.isNotEmpty)
                        CartInfo(userModel: userModel),
                      const Gap(10),
                      ProductInfo(
                        cartProductList: cartProductList,
                        cartToppingList: cartToppingList,
                      ),
                      const Gap(10),
                      CartCheckout(selectedVoucher: widget.selectedVoucher),
                      const Gap(10),
                      CartConfirm(
                        userModel: userModel,
                        cartProductList: cartProductList,
                        carttoppingList: cartToppingList,
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   img_url + "/empty-cart.png",
                    //   width: 200,
                    // ),
                    Image.network(
                      net_img_url + "empty_cart.png",
                      width: 150,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Gap(8),
                    Text(
                      '"Hổng" có gì trong giỏ hết',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Gap(8),
                    TextButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Color.fromARGB(255, 255, 244, 227))),
                        onPressed: () {
                          Routes.push(
                              widget: BottomNav(
                                selectedIndex: 1,
                              ),
                              context: context);
                        },
                        child: const Text(
                          'Mua sắm ngay',
                          style: TextStyle(color: Colors.orange),
                        ))
                  ],
                ),
              ),
      ),
    );
  }
  void _showClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn xóa sản phẩm không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Provider.of<AppProvider>(context, listen: false).clearCart();
              },
            ),
          ],
        );
      },
    );
  }
}

class CartInfo extends StatelessWidget {
  const CartInfo({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 3,
          spreadRadius: 0,
          offset: Offset(
            0,
            1,
          ),
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.06),
          blurRadius: 2,
          spreadRadius: 0,
          offset: Offset(
            0,
            1,
          ),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Giao hàng tận nơi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Gap(15),
          Row(
            children: [
              Text(userModel.address),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              )
            ],
          ),
          Gap(15),
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  userModel.fullName,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(userModel.phoneNumber),
              ]),
              Gap(50),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Hôm nay",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "Sớm nhất có thể",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo(
      {super.key,
      required this.cartProductList,
      required this.cartToppingList});
  final List<ProductModel> cartProductList;
  final List<ToppingModel> cartToppingList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 3,
          spreadRadius: 0,
          offset: Offset(
            0,
            1,
          ),
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.06),
          blurRadius: 2,
          spreadRadius: 0,
          offset: Offset(
            0,
            1,
          ),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Sản phẩm đã chọn",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const Spacer(),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 244, 227))),
                  onPressed: () {
                    Routes.push(
                        widget: BottomNav(
                          selectedIndex: 1,
                        ),
                        context: context);
                  },
                  child: const Text(
                    '+ Thêm',
                    style: TextStyle(color: Colors.orange),
                  ))
            ],
          ),
          const Gap(10),
          cartProductList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartProductList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cartProductList[index].name,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(numberFormatter(
                                    cartProductList[index].price)),
                                Text(cartProductList[index].qtyCart.toString()),
                                Text(numberFormatter(
                                    cartProductList[index].price *
                                        cartProductList[index].qtyCart!))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Text("Chưa chọn sản phẩm"),
          if (cartToppingList.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartToppingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cartToppingList[index].toppingName,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(numberFormatter(
                                double.parse(cartToppingList[index].price))),
                            Text(cartToppingList[index].qtyCart.toString()),
                            Text(numberFormatter(
                                double.parse(cartToppingList[index].price) *
                                    cartToppingList[index].qtyCart!))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}

class CartCheckout extends StatelessWidget {
  final int selectedVoucher;

  const CartCheckout({super.key, required this.selectedVoucher});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    double shippingFee = 7000;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 3,
          spreadRadius: 0,
          offset: Offset(
            0,
            1,
          ),
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.06),
          blurRadius: 2,
          spreadRadius: 0,
          offset: Offset(
            0,
            1,
          ),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tổng cộng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const Gap(12),
          Row(
            children: [
              Text(
                "Thành tiền",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(numberFormatter(appProvider.totalPrice()))
            ],
          ),
          const Gap(10),
          Row(
            children: [
              Text(
                "Phí giao hàng",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(numberFormatter(shippingFee))
            ],
          ),
          const Gap(10),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartVoucher()));
            },
            child: const Row(
              children: [
                Text(
                  "Chọn khuyên mãi",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                )
              ],
            ),
          ),
          const Gap(15),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Row(
            children: [
              Text(
                "Số tiền cần thanh toán",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Spacer(),
              Text(numberFormatter(appProvider.totalPrice() + shippingFee))
            ],
          ),
          Text('$selectedVoucher')
        ],
      ),
    );
  }
}

class CartConfirm extends StatefulWidget {
  final UserModel userModel;
  final List<ProductModel> cartProductList;
  final List<ToppingModel> carttoppingList;

  const CartConfirm(
      {super.key,
      required this.userModel,
      required this.cartProductList,
      required this.carttoppingList});

  @override
  State<CartConfirm> createState() => _CartConfirmState();
}

class _CartConfirmState extends State<CartConfirm> {
  PaymentMethodData? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    double shippingFee = 7000;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentOption()),
            );

            if (result != null && result is PaymentMethodData) {
              setState(() {
                _selectedPaymentMethod = result;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  1,
                ),
              ),
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.06),
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  1,
                ),
              ),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "Chọn phương thức thanh toán",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ],
                ),
                if (_selectedPaymentMethod != null)
                  Column(
                    children: [
                      const Gap(14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(_selectedPaymentMethod!.imageUrl),
                            height: 35,
                          ),
                          const Gap(10),
                          Text(_selectedPaymentMethod!.methodName)
                        ],
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
        const Gap(10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 254, 227, 195),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 3,
                  spreadRadius: 0,
                  offset: Offset(
                    0,
                    1,
                  ),
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(
                    0,
                    1,
                  ),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Giao hàng ${appProvider.getCartProductList.length + appProvider.getCartToppingList.length} sản phẩm",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(
                        numberFormatter(
                            appProvider.totalPriceWithShippingFee(shippingFee)),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(Colors.white)),
                      onPressed: () async {
                        if (widget.cartProductList.isEmpty)
                          showMessage('Chưa có sản phẩm, hãy chọn mua');
                        // Routes.push(
                        //     widget: BottomNav(
                        //       selectedIndex: 1,
                        //     ),
                        //     context: context);
                        List<ProductOrderModel> productOrderList = [];
                        for (int i = 0;
                            i < widget.cartProductList.length;
                            i++) {
                          ProductOrderModel productOrderModel =
                              ProductOrderModel(
                                  productId: widget.cartProductList[i].id,
                                  quantity: widget.cartProductList[i].qtyCart!,
                                  totalPrice: (widget.cartProductList[i].price *
                                          widget.cartProductList[i].qtyCart!)
                                      .toInt());
                          productOrderList.add(productOrderModel);
                          print(jsonEncode(productOrderList));
                        }

                        //List<IdProductData> idProductDataList = [];
                        //  for (int i = 0; i< widget.cartProductList.length; i++){

                        //   idProductDataList.add(idProductData);
                        //   }
                        // IdProductData idProductData = IdProductData(
                        //     id: widget.cartProductList[0].id,
                        //     name: widget.cartProductList[0].name,
                        //     image: widget.cartProductList[0].image,
                        //     price: widget.cartProductList[0].price.toString());

                        OrderModel orderModel = OrderModel(
                            receiver: widget.userModel.fullName,
                            orderStatus: OrderStatus.Waiting.toJson(),
                            receivingPoint: widget.userModel.address,
                            phoneNumber: widget.userModel.phoneNumber,
                            totalValue: appProvider
                                .totalPriceWithShippingFee(shippingFee)
                                .toString(),
                            note: "",
                            payment: _selectedPaymentMethod?.paymentId == 0
                                ? Payment.cod.toJson()
                                : Payment.atm.toJson(),
                            orderIdUser: widget.userModel.id,
                            productList: productOrderList,
                            toppings: widget.carttoppingList);
                        print(orderModel.toJson());
                        await ApiService.instance.createOrder(orderModel);
                        showMessage('Đặt hàng thành công');
                        appProvider.clearCart();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartSuccess()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Đặt hàng',
                          style: TextStyle(color: Colors.orange, fontSize: 16),
                        ),
                      ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
