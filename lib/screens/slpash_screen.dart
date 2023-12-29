import 'dart:async';
import 'package:dat_delivery/controller/account_controller.dart';
import 'package:dat_delivery/screens/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'screens/home/home_screen_drawer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final accountController = Get.find<AccountController>();
  @override
  void initState() {
    super.initState();

    simulateInitialDataLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LottieBuilder.asset(
          "assets/animations/delivery_man_stop.json",
          width: 250.w,
          height: 250.w,
        ),
      ),
    );
  }

  Future<Timer> simulateInitialDataLoading() async {
    await accountController.getUserFromSharedPreferences();
    if (accountController.accountSession.value != null) {
      return Timer(
        const Duration(seconds: 2),
        () => Get.offAll(
          MainScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(
            milliseconds: 1000,
          ),
        ),
      );
    }
    return Timer(
      const Duration(seconds: 2),
      () => Get.offAll(
        LoginScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(
          milliseconds: 1000,
        ),
      ),
    );
  }
}
