import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/models/order_detail_model.dart';
import 'package:flutter_coffee_app/models/order_model.dart';
import 'package:flutter_coffee_app/screen/order/order_tracking.dart';
import 'package:flutter_coffee_app/screen/order/order_details.dart';
import 'package:flutter_coffee_app/utils/number.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<OrderModel> orderList = [];
  List<OrderDetailModel> orderDetailList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getOrder();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  void getOrder() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    List<OrderModel> orders =
        await ApiService.instance.getOrders(appProvider.getUserInformation.id);
    setState(() {
      orderList = orders;
    });
    for (int i = 0; i < orderList.length; i++) {
      getOrderDetail(orders[i].id!);
    }
  }

  getOrderDetail(int orderId) async {
    List<OrderDetailModel> orderDetails = [];

    orderDetails = await ApiService.instance.getOrderDetail(orderId);

    setState(() {
      orderDetailList = orderDetails;
    });
    for (int i = 0; i < orderDetailList.length; i++) {
      print("orderDetailList" + orderDetailList[i].toJson());
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử mua hàng'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.orange,
          tabs: [
            Tab(
              child: Text(
                'Đang thực hiện',
                style: TextStyle(
                    color:
                        _tabController.index == 0 ? Colors.orange : Colors.grey,
                    fontSize: 10),
              ),
            ),
            Tab(
              child: Text(
                'Đã hoàn tất',
                style: TextStyle(
                    color:
                        _tabController.index == 1 ? Colors.orange : Colors.grey,
                    fontSize: 10),
              ),
            ),
            Tab(
              child: Text(
                'Đã hủy',
                style: TextStyle(
                    color:
                        _tabController.index == 2 ? Colors.orange : Colors.grey,
                    fontSize: 10),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: orderList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    await getOrderDetail(orderList[index].id!);
                    if (orderList[index].orderStatus == 'Đang chờ để duyệt' ||
                        orderList[index].orderStatus == 'Đang pha chế' ||
                        orderList[index].orderStatus == 'Đang giao hàng') {
                      Routes.push(
                          context: context,
                          widget: OrderTrackingPage(
                            status: orderList[index].orderStatus,
                            orderId: orderList[index].id!,
                            totalPrice: orderList[index].totalValue,
                            quantity: orderDetailList.length,
                          ));
                    }
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    '${orderList[index].id}',
                                    style: const TextStyle(),
                                  ),
                                  // Image.network(
                                  //   net_img_url +
                                  //       orderDetailList[0].idProductData.image,
                                  //   width: 80,
                                  // ),
                                  Gap(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Người nhận: ${orderList[index].receiver}',
                                        style: const TextStyle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Số điện thoại: ${orderList[index].phoneNumber}',
                                        style: const TextStyle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Tổng tiền: ${numberFormatter(double.parse(orderList[index].totalValue))}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                orderList[index].orderStatus,
                                style: const TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Center(child: Text('Chưa có đơn hàng đã giao')),
          Center(child: Text('Chưa có đơn hàng đã hủy ')),

          // // Da hoan tat
          // SingleChildScrollView(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: orderList.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return GestureDetector(
          //         onTap: () async {
          //           await getOrderDetail(orderList[index].id!);
          //           if (orderList[index].orderStatus == 'Đang chờ để duyệt' ||
          //               orderList[index].orderStatus == 'Đang pha chế' ||
          //               orderList[index].orderStatus == 'Đang giao hàng') {
          //             Routes.push(
          //                 context: context,
          //                 widget: OrderTrackingPage(
          //                   status: orderList[index].orderStatus,
          //                   orderId: orderList[index].id!,
          //                   totalPrice: orderList[index].totalValue,
          //                   quantity: orderDetailList.length,
          //                 ));
          //           }
          //         },
          //         child: Card(
          //           margin: const EdgeInsets.all(8.0),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 const Divider(),
          //                 Padding(
          //                   padding: const EdgeInsets.symmetric(vertical: 4.0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         // Text(
          //                         //   'Mã đơn hàng: ${orderList[index].id}',
          //                         //   style: const TextStyle(),
          //                         // ),
          //                         Image.network(
          //                           net_img_url +
          //                               orderDetailList[0].idProductData.image,
          //                           width: 80,
          //                         ),
          //                         Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Text(
          //                               'Người nhận: ${orderList[index].receiver}',
          //                               style: const TextStyle(),
          //                               maxLines: 1,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                             Text(
          //                               'Số điện thoại: ${orderList[index].phoneNumber}',
          //                               style: const TextStyle(),
          //                               maxLines: 1,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                             Text(
          //                               'Tổng tiền: ${numberFormatter(double.parse(orderList[index].totalValue))}',
          //                               style: const TextStyle(
          //                                   fontWeight: FontWeight.bold),
          //                               textAlign: TextAlign.end,
          //                               maxLines: 1,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 Align(
          //                   alignment: Alignment.centerRight,
          //                   child: Container(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal: 8, vertical: 4),
          //                     child: Text(
          //                       'Đã hoàn tất',
          //                       style: const TextStyle(color: Colors.white),
          //                     ),
          //                     decoration: BoxDecoration(
          //                         color: Colors.orange,
          //                         borderRadius: BorderRadius.circular(8)),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          // // Da hoan tat
          // SingleChildScrollView(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: orderList.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return GestureDetector(
          //         onTap: () async {
          //           await getOrderDetail(orderList[index].id!);
          //           if (orderList[index].orderStatus == 'Đang chờ để duyệt' ||
          //               orderList[index].orderStatus == 'Đang pha chế' ||
          //               orderList[index].orderStatus == 'Đang giao hàng') {
          //             Routes.push(
          //                 context: context,
          //                 widget: OrderTrackingPage(
          //                   status: orderList[index].orderStatus,
          //                   orderId: orderList[index].id!,
          //                   totalPrice: orderList[index].totalValue,
          //                   quantity: orderDetailList.length,
          //                 ));
          //           }
          //         },
          //         child: Card(
          //           margin: const EdgeInsets.all(8.0),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 const Divider(),
          //                 Padding(
          //                   padding: const EdgeInsets.symmetric(vertical: 4.0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         // Text(
          //                         //   'Mã đơn hàng: ${orderList[index].id}',
          //                         //   style: const TextStyle(),
          //                         // ),
          //                         Image.network(
          //                           net_img_url +
          //                               orderDetailList[0].idProductData.image,
          //                           width: 80,
          //                         ),
          //                         Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Text(
          //                               'Người nhận: ${orderList[index].receiver}',
          //                               style: const TextStyle(),
          //                               maxLines: 1,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                             Text(
          //                               'Số điện thoại: ${orderList[index].phoneNumber}',
          //                               style: const TextStyle(),
          //                               maxLines: 1,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                             Text(
          //                               'Tổng tiền: ${numberFormatter(double.parse(orderList[index].totalValue))}',
          //                               style: const TextStyle(
          //                                   fontWeight: FontWeight.bold),
          //                               textAlign: TextAlign.end,
          //                               maxLines: 1,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 Align(
          //                   alignment: Alignment.centerRight,
          //                   child: Container(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal: 8, vertical: 4),
          //                     child: Text(
          //                       'Đã hủy',
          //                       style: const TextStyle(color: Colors.white),
          //                     ),
          //                     decoration: BoxDecoration(
          //                         color: Colors.red,
          //                         borderRadius: BorderRadius.circular(8)),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          // items: ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: orderDetailList.length,
          //   itemBuilder: (context, index) {
          //     return _buildOrderItem(
          //       img: orderDetailList[index].idProductData.image,
          //       title: orderDetailList[index].idProductData.name,
          //       time: '12:15 - 01/06/2024',
          //       price: orderDetailList[index].idProductData.price,
          //     );
          //   },
          // ),

          // ListView(
          //   children: [
          //     _buildGroupedOrder(
          //       items: _buildOrderItem(
          //         icon: Icons.local_cafe,
          //         title: 'Trà sữa socola',
          //         time: '12:15 - 01/06/2024',
          //         price: '25.000đ',
          //       ),
          //       totalPrice: '43.000đ',
          //       status: 'Đang vận chuyển',
          //       statusColor: Colors.orange,
          //     ),
          //     _buildSingleOrder(
          //       icon: Icons.local_cafe,
          //       title: 'Trà sữa trân châu hoàng gia',
          //       time: '12:30 - 02/06/2024',
          //       price: '18.000đ',
          //       status: 'Đang pha chế',
          //       statusColor: Colors.orange,
          //     ),
          //   ],
          // ),
          // ListView(
          //   children: [
          //     _buildGroupedOrder(
          //       items: _buildOrderItem(
          //         icon: Icons.local_cafe,
          //         title: 'Trà đào cam sả',
          //         time: '15:30 - 03/06/2024',
          //         price: '30.000đ',
          //       ),
          //       totalPrice: '50.000đ',
          //       status: 'Đã hoàn tất',
          //       statusColor: Colors.green,
          //     ),
          //     _buildSingleOrder(
          //       icon: Icons.local_cafe,
          //       title: 'Cà phê sữa đá',
          //       time: '16:00 - 04/06/2024',
          //       price: '22.000đ',
          //       status: 'Đã hoàn tất',
          //       statusColor: Colors.green,
          //     ),
          //     _buildSingleOrder(
          //       icon: Icons.local_cafe,
          //       title: 'Cà phê đen đá',
          //       time: '17:00 - 04/06/2024',
          //       price: '18.000đ',
          //       status: 'Đã hoàn tất',
          //       statusColor: Colors.green,
          //     ),
          //   ],
          // ),
          // ListView(
          //   children: [
          //     _buildGroupedOrder(
          //       items: [
          //         _buildOrderItem(
          //           icon: Icons.local_cafe,
          //           title: 'Trà sữa matcha',
          //           time: '10:15 - 07/06/2024',
          //           price: '25.000đ',
          //         ),
          //         _buildOrderItem(
          //           icon: Icons.local_cafe,
          //           title: 'Trà sữa hạt dẻ',
          //           time: '10:30 - 07/06/2024',
          //           price: '30.000đ',
          //         ),
          //       ],
          //       totalPrice: '55.000đ',
          //       status: 'Đã hủy',
          //       statusColor: Colors.red,
          //     ),
          //     _buildSingleOrder(
          //       icon: Icons.local_cafe,
          //       title: 'Trà sữa ô long',
          //       time: '11:00 - 08/06/2024',
          //       price: '20.000đ',
          //       status: 'Đã hủy',
          //       statusColor: Colors.red,
          //     ),
          //     _buildSingleOrder(
          //       icon: Icons.local_cafe,
          //       title: 'Trà sữa khoai môn',
          //       time: '11:30 - 09/06/2024',
          //       price: '22.000đ',
          //       status: 'Đã hủy',
          //       statusColor: Colors.red,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  // Widget _buildGroupedOrder({
  //   Widget? items,
  //   required String totalPrice,
  //   required String status,
  //   required Color statusColor,
  // }) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (status == 'Đang chờ để duyệt' ||
  //           status == 'Đang pha chế' ||
  //           status == 'Đang giao hàng' ||
  //           status == 'Hoàn thành') {
  //         _navigateToOrderTracking(context, status);
  //       }
  //     },
  //     child: Card(
  //       margin: const EdgeInsets.all(8.0),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             items!,
  //             const Divider(),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 4.0),
  //               child: Container(
  //                 width: double.infinity,
  //                 child: Text(
  //                   'Tổng tiền: $totalPrice',
  //                   style: const TextStyle(fontWeight: FontWeight.bold),
  //                   textAlign: TextAlign.end,
  //                 ),
  //               ),
  //             ),
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                 child: Text(
  //                   status,
  //                   style: const TextStyle(color: Colors.white),
  //                 ),
  //                 decoration: BoxDecoration(
  //                     color: statusColor,
  //                     borderRadius: BorderRadius.circular(8)),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSingleOrder({
  //   required IconData icon,
  //   required String title,
  //   required String time,
  //   required String price,
  //   required String status,
  //   required Color statusColor,
  // }) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (status == 'Đang vận chuyển' ||
  //           status == 'Đang pha chế' ||
  //           status == 'Đã hoàn tất') {
  //         _navigateToOrderTracking(context, status);
  //       }
  //     },
  //     child: Card(
  //       margin: const EdgeInsets.all(8.0),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: ListTile(
  //           leading: Icon(icon, size: 40),
  //           title: Text(title),
  //           subtitle: Text(time),
  //           trailing: Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Text(
  //                 price,
  //                 style: TextStyle(fontSize: 14),
  //               ),
  //               const SizedBox(height: 4),
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                 child: Text(
  //                   status,
  //                   style: const TextStyle(color: Colors.white),
  //                 ),
  //                 decoration: BoxDecoration(
  //                     color: statusColor,
  //                     borderRadius: BorderRadius.circular(8)),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildOrderItem({
    IconData? icon,
    String? img,
    required String title,
    required String time,
    required String price,
  }) {
    return ListTile(
      leading: Image.network(net_img_url + img!),
      title: Text(title),
      subtitle: Text(time),
      trailing: Text(
        price,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class OrderTrackingPage extends StatelessWidget {
  final String status;
  final int orderId;
  final String totalPrice;
  final int quantity;
  const OrderTrackingPage({
    required this.status,
    required this.orderId,
    required this.totalPrice,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi đơn hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: OrderStatusIndicator(status: status)),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: OrderItems(
                orderId: orderId,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Spacer(),
                  OrderSummary(
                    totalPrice: totalPrice,
                    orderId: orderId,
                    quantity: quantity,
                  ),
                  if (status == 'Hoàn thành')
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OrderDetailsPage(
                                    orderId: 1,
                                  )),
                        );
                      },
                      child: Text('Xem chi tiết đơn hàng'),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderStatusIndicator extends StatelessWidget {
  final String status;

  const OrderStatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              Icons.handyman_outlined,
              color:
                  status == 'Đang chờ để duyệt' ? Colors.orange : Colors.grey,
              size: 20,
            ),
            Text(
              'Đang chờ để duyệt',
              style: TextStyle(
                  color: status == 'Đang chờ để duyệt'
                      ? Colors.orange
                      : Colors.grey,
                  fontSize: 9),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.local_drink,
              color: status == 'Đang pha chế' ? Colors.orange : Colors.grey,
              size: 20,
            ),
            Text(
              'Đang pha chế',
              style: TextStyle(
                  color: status == 'Đang pha chế' ? Colors.orange : Colors.grey,
                  fontSize: 9),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.local_shipping,
              color: status == 'Đang giao hàng' ? Colors.orange : Colors.grey,
              size: 20,
            ),
            Text(
              'Đang giao hàng',
              style: TextStyle(
                  color:
                      status == 'Đang giao hàng' ? Colors.orange : Colors.grey,
                  fontSize: 9),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.check_circle,
              color: status == 'Hoàn thành' ? Colors.green : Colors.grey,
              size: 20,
            ),
            Text(
              'Hoàn thành',
              style: TextStyle(
                  color: status == 'Hoàn thành' ? Colors.green : Colors.grey,
                  fontSize: 9),
            ),
          ],
        ),
      ],
    );
  }
}

class OrderItems extends StatefulWidget {
  const OrderItems({super.key, required this.orderId});
  final int orderId;
  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  List<OrderDetailModel> orderDetailList = [];

  @override
  void initState() {
    getOrderDetail();
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
    return SingleChildScrollView(
      child: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: orderDetailList.length,
            itemBuilder: (context, index) {
              return OrderItem(
                name: orderDetailList[index].idProductData.name,
                price: orderDetailList[index].idProductData.price,
                img: orderDetailList[index].idProductData.image,
                quantity: orderDetailList[index].quantity,
              );
            },
          )
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String name;
  final String price;
  final String img;
  final int quantity;
  OrderItem(
      {required this.name,
      required this.price,
      required this.img,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Image.network(
              net_img_url + img,
              width: 80,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    numberFormatter(double.parse(price)),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              "x" + quantity.toString(),
              style: TextStyle(),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary(
      {super.key,
      required this.totalPrice,
      required this.orderId,
      required this.quantity});
  final int orderId;
  final int quantity;
  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(label: 'Mã đơn hàng', amount: orderId.toString()),
        SummaryRow(label: 'Số lượng', amount: quantity.toString()),
        Divider(),
        SummaryRow(
            label: 'Tổng tiền',
            amount: numberFormatter(double.parse(totalPrice)),
            isTotal: true),
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
