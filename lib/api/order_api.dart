import 'dart:convert';
import 'package:dat_delivery/api/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:dat_delivery/model/respone_base_model.dart';

class OrderApi {
  Future<ResponseBaseModel> getDeliverOrder(String deliveryId) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiGetDelivery}/$deliveryId"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel> changeOrderStatus(
      String orderId, String status) async {
    final response = await http.put(
      Uri.parse(
          "${ApiUrl.apiUpdateOrder}?orderId=$orderId&orderStatus=$status"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel> completeDelivery(String deliveryId) async {
    final response = await http.post(
      Uri.parse("${ApiUrl.apiCompleteDelivery}/$deliveryId"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }
}
