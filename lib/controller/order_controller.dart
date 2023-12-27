import 'package:dat_delivery/api/order_api.dart';
import 'package:dat_delivery/model/delivery_dto_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  late OrderApi _orderApi;
  RxList<DeliveryDTO> listDeliveryDetails = <DeliveryDTO>[].obs;
  @override
  void onInit() {
    super.onInit();
    _orderApi = OrderApi();
  }

  Future<void> getDeliverOrder(String deliverId) async {
    final response = await _orderApi.getDeliverOrder(deliverId);
    if (response.message == "Success") {
      final listDeliveryJson = response.data as List<dynamic>;
      listDeliveryDetails.value =
          listDeliveryJson.map((d) => DeliveryDTO.fromJson(d)).toList();
    }
  }
}
