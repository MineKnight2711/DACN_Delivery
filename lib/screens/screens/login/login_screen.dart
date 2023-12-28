// ignore_for_file: use_build_context_synchronously

import 'package:dat_delivery/config/font.dart';
import 'package:dat_delivery/controller/login_controller.dart';
import 'package:dat_delivery/screens/screens/home/home_screen_drawer.dart';
import 'package:dat_delivery/utils/custom_snackbar.dart';
import 'package:dat_delivery/utils/no_glowing_scrollview.dart';
import 'package:dat_delivery/utils/transition_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final loginController = Get.find<LoginController>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NoGlowingScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/bg-login.jpg",
              width: 320,
              height: 229,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 25,
                bottom: 20,
              ),
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              "Vui lòng đăng nhập để tiếp tục giao hàng...",
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
            const SizedBox(height: 20),

            Container(
              height: 50.h,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                vertical: 5.w,
                horizontal: 10.w,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: loginController.txtEmail,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Username',
                ),
              ),
            ),
            Container(
              height: 50.h,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                vertical: 5.w,
                horizontal: 10.w,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: loginController.txtPassword,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),
            //Forgot password
            const Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
            ),
            SizedBox(
              width: 300.w,
              height: 50.h,
              child: MaterialButton(
                color: const Color.fromARGB(255, 243, 114, 63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () async {
                  showLoadingAnimation(
                      context, "assets/animations/loading.json", 180);
                  String result = await loginController
                      .signIn()
                      .whenComplete(() => Get.back());
                  if (result == 'Success') {
                    CustomSnackBar.showCustomSnackBar(
                        context, "Đăng nhập thành công",
                        duration: 2,
                        isShowOnTop: false,
                        type: FlushbarType.success);
                    Get.to(() => HomeScreenDrawer());
                  } else {
                    CustomSnackBar.showCustomSnackBar(
                        context, "Đăng nhập thất bại",
                        duration: 2,
                        isShowOnTop: false,
                        type: FlushbarType.failure);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
