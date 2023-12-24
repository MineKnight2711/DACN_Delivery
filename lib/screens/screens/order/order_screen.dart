import 'package:flutter/material.dart';

class OrderManagementScreen extends StatefulWidget {
  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
        title: Text('Quản lý đơn hàng'),
        backgroundColor: const Color.fromARGB(255, 243, 114, 63),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black, // Màu của tab được chọn
            unselectedLabelColor:
                Colors.grey, // Màu của các tab không được chọn
            tabs: [
              Tab(text: 'Đơn cần vận chuyển'),
              Tab(text: 'Đang vận chuyển'),
              Tab(text: 'Đã vận chuyển'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: Text('Đơn cần vận chuyển'),
                ),
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
