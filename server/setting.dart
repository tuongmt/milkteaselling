import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/screen/login/login.dart';
import 'package:flutter_coffee_app/screen/order/order_history.dart'; // Import the new screen
import 'package:flutter_coffee_app/ui/head_nav.dart';
import 'package:gap/gap.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              child: HeadNav(greeting: "Khác")),
        ),
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            height: 800,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 234, 229, 229)),
            child: const SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Utitlity(), Help(), Account()],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Utitlity extends StatelessWidget {
  const Utitlity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Tiện ích',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  surfaceTintColor: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderHistory(), // Navigate to the OrderHistory screen
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      height: 90,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: Colors.deepOrange,
                          ),
                          Gap(5),
                          Text('Lịch sử đơn hàng',
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  surfaceTintColor: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      height: 90,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.policy_outlined,
                            color: Colors.purple,
                          ),
                          Gap(5),
                          Text('Điều khoản',
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(2),
          Card(
            surfaceTintColor: Colors.white,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 90,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.login_outlined,
                      color: Colors.deepOrangeAccent,
                    ),
                    Gap(5),
                    Text(
                      'Đăng nhập',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hỗ trợ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Gap(10),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              height: 150,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(Icons.star_border_outlined),
                            Gap(10),
                            Text(
                              'Đánh giá đơn hàng',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 5,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.messenger_outline_outlined),
                          Gap(10),
                          Text(
                            'Liên hệ và góp ý',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 5,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.dataset_linked_outlined),
                          Gap(10),
                          Text(
                            'Hướng dẫn xuất hóa đơn GTGT',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tài khoản',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Gap(10),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              height: 200,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(Icons.person_outline),
                            Gap(10),
                            Text(
                              'Cập nhật tài khoản',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 5,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.credit_card),
                          Gap(10),
                          Text(
                            'Tài khoản thanh toán',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 5,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.add_card_outlined),
                          Gap(10),
                          Text(
                            'Liên kết ngân hàng',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
