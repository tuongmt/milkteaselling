import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/main.dart';
import 'package:flutter_coffee_app/screen/menu/menu_screen.dart';
import 'package:flutter_coffee_app/screen/order/order_history.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CartSuccess extends StatelessWidget {
  const CartSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy hh:mm:ss');
    String formattedDate = formatter.format(now);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xfff5eddb),
            Color(0xfffcfcfc),
          ],
          stops: [0.5, 1],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Đặt hàng thành công',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ),
              const Gap(20),
              Icon(
                Icons.check_circle,
                size: 200,
                color: Colors.greenAccent.shade700,
              ),
              const Gap(15),
              Center(child: Text(formattedDate)),
              const Gap(30),
              const Text(
                'Đơn hàng của bạn sẽ sớm được giao tới',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the border radius
                          ),
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        Routes.push(
                            widget: const BottomNav(
                              selectedIndex: 1,
                            ),
                            context: context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Tiếp tục mua hàng',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      )),
                  const Gap(10),
                  TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderHistory()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Xem lịch sử mua hàng',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
