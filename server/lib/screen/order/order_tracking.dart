import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi đơn hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OrderStatusIndicator(),
            SizedBox(height: 20),
            OrderItems(),
            Spacer(),
            OrderSummary(),
          ],
        ),
      ),
    );
  }
}

class OrderStatusIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(Icons.local_drink, color: Colors.orange, size: 20),
            Text('Đang chờ để duyệt', style: TextStyle(color: Colors.orange)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.local_shipping, color: Colors.orange, size: 20),
            Text('Đang pha chế', style: TextStyle(color: Colors.orange)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.check_circle, color: Colors.grey, size: 20),
            Text('Đang giao hàng', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class OrderItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderItem(
          name: 'Trà sữa trân châu hoàng gia',
          price: '18.000đ',
          icon: Icons.coffee,
        ),
        OrderItem(
          name: 'Trà sữa socola',
          price: '25.000đ',
          icon: Icons.coffee,
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  final String name;
  final String price;
  final IconData icon;

  OrderItem({required this.name, required this.price, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 50, color: Colors.brown),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(price, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(label: 'Tiền nước', amount: '43.000đ'),
        SummaryRow(label: 'Vận chuyển', amount: '15.000đ'),
        Divider(),
        SummaryRow(label: 'Tổng tiền', amount: '58.000đ', isTotal: true),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;

  SummaryRow({required this.label, required this.amount, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontSize: 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderTrackingPage(),
  ));
}
