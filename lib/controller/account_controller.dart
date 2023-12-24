import 'dart:convert';

import 'package:dat_delivery/api/account_api.dart';
import 'package:dat_delivery/model/account_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  Rx<AccountModel?> accountSession = Rx<AccountModel?>(null);
  late AccountApi _accountApi;
  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
  }

  Future<void> fetchCurrentUser() async {
    if (accountSession.value != null) {
      final responseBaseModel =
          await _accountApi.getAccountByEmail("${accountSession.value?.email}");
      if (responseBaseModel.message == "Success") {
        accountSession.value = AccountModel.fromJson(responseBaseModel.data);
        await storedUserToSharedRefererces(
            AccountModel.fromJson(responseBaseModel.data));
        accountSession.value = await getUserFromSharedPreferences();
      }
    }
  }

  Future<void> storedUserToSharedRefererces(
      AccountModel accountResponse) async {
    final prefs = await SharedPreferences.getInstance();

    final accountJsonEncode = jsonEncode(accountResponse.toJson());
    await prefs.setString("current_account", accountJsonEncode);
  }

  Future<AccountModel?> getUserFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('current_account') ?? '';
    if (jsonString.isNotEmpty) {
      accountSession.value = AccountModel.fromJson(jsonDecode(jsonString));
      return accountSession.value;
    }
    return null;
  }

  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('current_account');
    accountSession.value = null;
    // MainController.destroyControllers();
  }
}
