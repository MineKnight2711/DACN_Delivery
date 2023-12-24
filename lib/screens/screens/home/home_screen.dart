import 'package:dat_delivery/config/font.dart';
import 'package:dat_delivery/controller/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../my_drawer_header.dart';
import '../login/login_screen.dart';
import '../order/order_screen.dart';
import '../settings/settings_screen.dart';
import 'main_deliver_screen.dart';

class HomeScreen extends StatelessWidget {
  final accountController = Get.find<AccountController>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deliver App Food'),
        backgroundColor: const Color.fromARGB(255, 243, 114, 63),
      ),
      drawer: MyDrawer(accountController: accountController),
      body: const MainDeliveryScreen(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final AccountController accountController;
  const MyDrawer({
    super.key,
    required this.accountController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(() {
            if (accountController.accountSession.value != null) {
              return MyDrawerHeader(
                imageAvatar: Image.network(
                        "${accountController.accountSession.value?.imageUrl}")
                    .image,
                name: "${accountController.accountSession.value?.fullName}",
                email: "${accountController.accountSession.value?.email}",
              );
            }
            return const MyDrawerHeader(
              imageAvatar: AssetImage('assets/image/avatar-gau-cute-11.jpg'),
              name: 'Huỳnh Phước Đạt',
              email: 'huynhphuocdat2@gmail.com',
            );
          }),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: Text(
              'Quản lý đơn hàng',
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
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
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () {
              accountController.logOut();
            },
          ),
        ],
      ),
    );
  }
}
