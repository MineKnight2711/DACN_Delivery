import 'dart:convert';
import 'package:dat_delivery/api/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:dat_delivery/model/respone_base_model.dart';

class AccountApi {
  Future<ResponseBaseModel> signIn(String email, String password) async {
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
      Uri.parse(ApiUrl.apiSignInWithFireBase),
      body: requestBody,
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

  Future<ResponseBaseModel> getAccountByEmail(String email) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiGetAccountWithEmail}/$email"),
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
