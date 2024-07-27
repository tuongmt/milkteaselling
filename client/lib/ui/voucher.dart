import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:styled_divider/styled_divider.dart';

class Voucher extends StatelessWidget {
  final bool showRadio;
  final int groupValue;
  final int value;
  final ValueChanged<int?> onChanged;

  const Voucher(
      {this.showRadio = false,
      this.groupValue = 0,
      this.value = 0,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 9,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: CardVoucher(
              showRadio: showRadio,
              groupValue: groupValue,
              value: index + 1,
              onChanged: onChanged,
            ));
      },
      padding: const EdgeInsets.only(top: 10, bottom: 100),
    );
  }
}

class CardVoucher extends StatelessWidget {
  final bool showRadio;
  final int groupValue;
  final int value;
  final ValueChanged<int?> onChanged;

  const CardVoucher({
    required this.showRadio,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image(
                        width: 72,
                        image: AssetImage('assets/images/coffee_talk.jpg')),
                  ),
                  StyledVerticalDivider(
                    color: Color.fromARGB(255, 203, 202, 197),
                    width: 50,
                    thickness: 2.5,
                    lineStyle: DividerLineStyle.dotted,
                  ),
                  Gap(10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tuần lễ vàng giảm giá trà sữa 30%',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Hết hạn trong 2 ngày',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showRadio)
            Radio<int>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
        ],
      ),
    );
  }
}
