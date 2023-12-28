import 'package:dat_delivery/controller/account_controller.dart';
import 'package:dat_delivery/controller/login_controller.dart';
import 'package:dat_delivery/controller/order_controller.dart';
import 'package:get/get.dart';

class MainController {
  static initializeControllers() async {
    Get.put(AccountController());
    Get.put(LoginController());
  }
}
