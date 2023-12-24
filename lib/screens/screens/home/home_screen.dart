import 'package:flutter/material.dart';

import '../../my_drawer_header.dart';
import '../login/login.dart';
import '../order/order_screen.dart';
import '../settings/settings_screen.dart';
import 'main_deliver_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deliver App Food'),
        backgroundColor: const Color.fromARGB(255, 243, 114, 63),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const MyDrawerHeader(
              avatarImageUrl: 'assets/image/avatar-gau-cute-11.jpg',
              name: 'Huỳnh Pước Đạt',
              email: 'huynhphuocdat2@gmail.com',
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
                leading: const Icon(Icons.update_outlined),
                title: const Text('Cập nhật thông tin'),
                onTap: () {}),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Đổi mật khẩu'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Quản lý đơn hàng'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderManagementScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy policy'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: const MainDeliveryScreen(),
    );
  }
}
