import 'package:dat_delivery/controller/main_controllers.dart';
import 'package:dat_delivery/screens/slpash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDateFormatting('vi_VN', null);
  MainController.initializeControllers();

  runApp(
    const ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: AppFood(),
    ),
  );
  await initializationSlpashScreen()
      .whenComplete(() => FlutterNativeSplash.remove());
}

Future<void> initializationSlpashScreen() async {
  return await Future.delayed(const Duration(seconds: 1));
}

class AppFood extends StatelessWidget {
  const AppFood({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: const [Locale("en", "US"), Locale("vi", "VN")],
      locale: const Locale("en", "US"),
      initialRoute: 'splash_screen',
      debugShowCheckedModeBanner: false,
      routes: {
        'splash_screen': (context) => const SplashScreen(),
      },
    );
  }
}
