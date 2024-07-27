import 'package:flutter/material.dart';

import '../ui/reward.dart';
import '../ui/voucher.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.orange,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text(
                  'Mã khuyến mãi',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Tab(
                child: Text(
                  'Đổi quà',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 243, 240, 240)),
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                // ignore: avoid_types_as_parameter_names
                Voucher(showRadio: false, onChanged: (int) {}),
                const Reward(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
