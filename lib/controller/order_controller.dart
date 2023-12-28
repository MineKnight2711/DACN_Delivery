import 'dart:async';

import 'package:dat_delivery/api/order_api.dart';
import 'package:dat_delivery/controller/account_controller.dart';
import 'package:dat_delivery/model/delivery_dto_model.dart';
import 'package:dat_delivery/model/respone_base_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  late OrderApi _orderApi;
  late AccountController _accountController;
  RxList<String> tabs = <String>[].obs;
  RxList<DeliveryDTO> listDetails = <DeliveryDTO>[].obs;
  RxList<DeliveryDTO> listAsignedDetails = <DeliveryDTO>[].obs;
  RxList<DeliveryDTO> listOnDeliveryDetails = <DeliveryDTO>[].obs;
  RxList<DeliveryDTO> listDeliveredDetails = <DeliveryDTO>[].obs;
  @override
  void onInit() {
    super.onInit();
    _orderApi = OrderApi();
    _accountController = Get.find<AccountController>();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      getDeliverOrder();
    });
    initializeTabs();
  }

  void initializeTabs() {
    tabs.value = [
      'Đơn cần vận chuyển',
      'Đang vận chuyển',
      'Đã hoàn tất',
    ];
  }

  Future<void> getDeliverOrder() async {
    if (_accountController.accountSession.value != null) {
      final response = await _orderApi.getDeliverOrder(
          "${_accountController.accountSession.value?.accountID}");
      if (response.message == "Success") {
        final listDeliveryJson = response.data as List<dynamic>;
        listDetails.value =
            listDeliveryJson.map((d) => DeliveryDTO.fromJson(d)).toList();
        listAsignedDetails.value = listDetails
            .where((orderDetails) =>
                orderDetails.details?.order?.status == "Đang thực hiện")
            .toList();
      }
    }
  }

  void getOrderByStatus(String status) {
    switch (status) {
      case "Đơn cần vận chuyển":
        listAsignedDetails.value = listDetails
            .where((orderDetails) =>
                orderDetails.details?.order?.status == "Đang thực hiện")
            .toList();
        break;
      case "Đang vận chuyển":
        listOnDeliveryDetails.value = listDetails
            .where((orderDetails) =>
                orderDetails.details?.order?.status == "Đang vận chuyển")
            .toList();
        break;
      case "Đã hoàn tất":
        listDeliveredDetails.value = listDetails
            .where((orderDetails) =>
                orderDetails.details?.order?.status == "Đã hoàn tất")
            .toList();
        break;

      default:
    }
  }

  Future<ResponseBaseModel> changeOrderStatus(
      String orderId, String status) async {
    final response = await _orderApi.changeOrderStatus(orderId, status);
    return response;
  }

  Future<ResponseBaseModel> completeDelivery(String deliveryId) async {
    final response = await _orderApi.completeDelivery(deliveryId);
    return response;
  }
}
