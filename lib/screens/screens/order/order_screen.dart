import 'package:dat_delivery/controller/order_controller.dart';
import 'package:dat_delivery/screens/screens/order/components/delivery_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final orderController = Get.find<OrderController>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
        backgroundColor: const Color.fromARGB(255, 243, 114, 63),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black, // Màu của tab được chọn
            unselectedLabelColor:
                Colors.grey, // Màu của các tab không được chọn
            tabs: const [
              Tab(text: 'Đơn cần vận chuyển'),
              Tab(text: 'Đang vận chuyển'),
              Tab(text: 'Đã vận chuyển'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Obx(() {
                  if (orderController.listDeliveryDetails.isNotEmpty) {
                    return Column(
                        children: orderController.listDeliveryDetails
                            .map((order) => DeliveryItem(
                                  buttonTitle: "Nhận đơn",
                                  onPressed: () {},
                                  delivery: order,
                                ))
                            .toList());
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
                Center(
                  child: Text('Đang vận chuyển'),
                ),
                Center(
                  child: Text('Đã giao'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
