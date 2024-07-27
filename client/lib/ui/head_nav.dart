import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/main.dart';
import 'package:flutter_coffee_app/ui/voucher.dart';
import 'package:gap/gap.dart';

class HeadNav extends StatelessWidget {
  final String greeting;
  const HeadNav({super.key, required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.sunny,
              color: Colors.amber,
            ),
            const Gap(12),
            Text(
              greeting,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const Spacer(),
            InkWell(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 70,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(149, 157, 165, 0.2),
                            blurRadius: 24,
                            spreadRadius: 0,
                            offset: Offset(0, 8),
                          ),
                        ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Routes.push(
                          widget: BottomNav(
                            selectedIndex: 2,
                          ),
                          context: context);
                    },
                    child: const SizedBox(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.confirmation_num_outlined,
                            color: Colors.orange,
                          ),
                          Text('12',
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(8),
            InkWell(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(149, 157, 165, 0.2),
                            blurRadius: 24,
                            spreadRadius: 0,
                            offset: Offset(0, 8),
                          ),
                        ]),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_outlined),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(20)
      ],
    );
  }
}
