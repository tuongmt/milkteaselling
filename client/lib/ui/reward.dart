import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Reward extends StatelessWidget {
  const Reward({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 20, bottom: 150),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 20,
      children: List.generate(8, (index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: 200,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: const Image(
                            image: AssetImage('assets/images/card_image.jpg')),
                      ),
                      const Gap(6),
                      const Text(
                        'BÌNH GIỮ NHIỆT TUMBLER EVERYDAY',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            fontSize: 13),
                      ),
                      const Gap(4),
                      const Row(
                        children: [
                          Text('Đổi 1400',
                              style:
                                  TextStyle(letterSpacing: 0.5, fontSize: 13)),
                          Gap(3),
                          Icon(
                            Icons.money,
                            color: Colors.orangeAccent,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
