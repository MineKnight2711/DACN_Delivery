import 'package:dat_delivery/api/account_api.dart';
import 'package:dat_delivery/controller/account_controller.dart';
import 'package:dat_delivery/model/account_model.dart';
import 'package:dat_delivery/model/respone_base_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late AccountApi _accountApi;
  late AccountController _accountController;
  TextEditingController txtEmail = TextEditingController();

  TextEditingController txtPassword = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
    _accountController = Get.find<AccountController>();
  }

  void clearText() {
    txtEmail.clear();
    txtPassword.clear();
  }

  Future<String> getAccountFromDatabase(String email) async {
    ResponseBaseModel responseBaseModel =
        await _accountApi.getAccountByEmail(email);
    if (responseBaseModel.message == "Success") {
      _accountController.accountSession.value =
          AccountModel.fromJson(responseBaseModel.data);
      await _accountController.storedUserToSharedRefererces(
          AccountModel.fromJson(responseBaseModel.data));
      clearText();
      return "Success";
    }
    return responseBaseModel.message ?? "";
  }

  Future<String> signIn() async {
    final signInResponse =
        await _accountApi.signIn(txtEmail.text, txtPassword.text);
    if (signInResponse.message == "Success") {
      await getAccountFromDatabase(txtEmail.text);
      return signInResponse.message ?? '';
    }
    return "AccountNotFound";
  }
}
