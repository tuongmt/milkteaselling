import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/models/order_detail_model.dart';
import 'package:gap/gap.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.orderId});
  final int orderId;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  List<OrderDetailModel> orderDetailList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getOrderDetail() async {
    List<OrderDetailModel> orderDetails = [];

    orderDetails = await ApiService.instance.getOrderDetail(widget.orderId);

    setState(() {
      orderDetailList = orderDetails;
    });
    for (int i = 0; i < orderDetailList.length; i++) {
      print(orderDetailList[i].toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Chi tiết đơn hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Thông tin đơn hàng',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tên người nhận",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Mã Tuấn Tường",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Số điện thoại",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "0123456789",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Giao đến",
                          style: TextStyle(fontSize: 14),
                        ),
                        Gap(4),
                        Text(
                          "110 Nguyễn Chí Thanh, phường 16, quận 11",
                          style: TextStyle(fontSize: 16),
                        ),
                        Gap(4),
                        Text(
                          "Trạng thái thanh toán",
                          style: TextStyle(fontSize: 14),
                        ),
                        Gap(4),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                            ),
                            Gap(4),
                            Text(
                              "Đã thanh toán",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Gap(20),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sản phẩm đã chọn ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Gap(8),
                    OrderDetailsItem(
                      name: 'Trà sữa trân châu hoàng gia',
                      price: '18.000đ',
                      quantity: 1,
                      size: 'S',
                    ),
                    OrderDetailsItem(
                      name: 'Trà sữa socola',
                      price: '25.000đ',
                      quantity: 1,
                      size: 'S',
                    ),
                  ],
                ),
              ),
              Gap(20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tổng cộng',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Thành tiền'),
                          Text('43.000đ'),
                        ],
                      ),
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phí giao hàng'),
                          Text('15.000đ'),
                        ],
                      ),
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Chọn khuyến mãi'),
                          Text('  '),
                        ],
                      ),
                      Divider(),
                      SummaryRow(
                          label: 'Số tiền cần thanh toán',
                          amount: '58.000đ',
                          isTotal: true),
                      Gap(4),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                          ),
                          Gap(4),
                          Text('Thanh toán bằng tiền mặt')
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderDetailsItem extends StatelessWidget {
  final String name;
  final String price;
  final int quantity;
  final String size;

  OrderDetailsItem(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(quantity.toString(), style: TextStyle(fontSize: 16)),
                  Gap(4),
                  Text(name, style: TextStyle(fontSize: 16)),
                ],
              ),
              Gap(4),
              Text('Size $size', style: TextStyle(fontSize: 12)),
            ],
          ),
          Text(price, style: TextStyle(fontSize: 16)),
        ],
      ),
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
          Text(label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(amount,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
