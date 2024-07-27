import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum PaymentMethod { cash, momo }

class PaymentMethodData {
  final int paymentId;
  final PaymentMethod method;
  final String imageUrl;
  final String methodName;

  PaymentMethodData({
    this.paymentId = 0,
    required this.method,
    required this.imageUrl,
    required this.methodName,
  });
}

class PaymentOption extends StatefulWidget {
  const PaymentOption({super.key});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  PaymentMethod? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Phương thức thanh toán",
            style: TextStyle(fontSize: 19),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Row(
                  children: [
                    Image(
                      image: AssetImage("assets/images/pay_option_1.jfif"),
                      height: 35,
                    ),
                    Gap(15),
                    Text('Tiền mặt')
                  ],
                ),
                leading: Radio<PaymentMethod>(
                  value: PaymentMethod.cash,
                  groupValue: _selectedMethod,
                  onChanged: (PaymentMethod? value) {
                    setState(() {
                      _selectedMethod = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Row(
                  children: [
                    Image(
                      image: AssetImage("assets/images/pay_option_2.png"),
                      height: 35,
                    ),
                    Gap(30),
                    Text('Momo')
                  ],
                ),
                leading: Radio<PaymentMethod>(
                  value: PaymentMethod.momo,
                  groupValue: _selectedMethod,
                  onChanged: (PaymentMethod? value) {
                    setState(() {
                      _selectedMethod = value;
                    });
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.orangeAccent)),
                  onPressed: () {
                    if (_selectedMethod != null) {
                      String imageUrl = _selectedMethod == PaymentMethod.cash
                          ? "assets/images/pay_option_1.jfif"
                          : "assets/images/pay_option_2.png";
                      String methodName = _selectedMethod == PaymentMethod.cash
                          ? "Tiền mặt"
                          : "Momo";
                      int paymentId =
                          _selectedMethod == PaymentMethod.cash ? 0 : 1;

                      PaymentMethodData selectedMethod = PaymentMethodData(
                        paymentId: paymentId,
                        method: _selectedMethod!,
                        imageUrl: imageUrl,
                        methodName: methodName,
                      );
                      Navigator.pop(context, selectedMethod);
                    }
                  },
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
