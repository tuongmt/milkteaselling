import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/screen/cart/cart_detail.dart';
import 'package:flutter_coffee_app/ui/voucher.dart';

class CartVoucher extends StatefulWidget {
  const CartVoucher({super.key});

  @override
  State<CartVoucher> createState() => _CartVoucherState();
}

class _CartVoucherState extends State<CartVoucher> {
  int _selectedVoucher = 1; // initial value for selected voucher
  // String _selectedVoucherText = '';

  void _onRadioChanged(int? value) {
    setState(() {
      _selectedVoucher = value!;
    });
  }

  void _navigateToCartDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartDetail(selectedVoucher: _selectedVoucher, ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher của bạn'),
      ),
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xfffcfcfc), Color(0xfff5eddb)],
              stops: [0.5, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            height: MediaQuery.of(context).size.height,
            child: Voucher(
              showRadio: true,
              groupValue: _selectedVoucher,
              onChanged: _onRadioChanged,
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<WidgetState> states) {
                      return const EdgeInsets.all(14);
                    },
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(Colors.orange.shade700)),
              onPressed: () => _navigateToCartDetail(context),
              child: const Text('Chọn voucher',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ]),
    );
  }
}
