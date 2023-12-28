// ignore_for_file: use_build_context_synchronously

import 'package:dat_delivery/config/colors.dart';
import 'package:dat_delivery/controller/map_controller.dart';
import 'package:dat_delivery/utils/custom_snackbar.dart';
import 'package:dat_delivery/utils/transition_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MainDeliveryScreen extends StatefulWidget {
  const MainDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<MainDeliveryScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<MainDeliveryScreen> {
  final mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange100,
      body: Stack(
        children: [
          SizedBox(
            child: MapWidget(
              key: const ValueKey("mapWidget"),
              resourceOptions: ResourceOptions(
                  accessToken:
                      "pk.eyJ1IjoidGluaGthaXQiLCJhIjoiY2xoZXhkZmJ4MTB3MzNqczdza2MzcHE2YSJ9.tPQwbEWtA53iWlv3U8O0-g"),
              cameraOptions: CameraOptions(
                center: Point(coordinates: Position(106.702765, 11)).toJson(),
                zoom: mapController.zoomLevel.value,
              ),
              styleUri: MapboxStyles.MAPBOX_STREETS,
              textureView: true,
              onMapCreated: mapController.onMapCreated,
            ),
          ),
          Positioned(
            bottom: 130,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MapNavigateButton(
                    onPressed: mapController.zoomIn,
                    iconData: CupertinoIcons.zoom_in),
                MapNavigateButton(
                    onPressed: mapController.zoomOut,
                    iconData: CupertinoIcons.zoom_out),
                MapNavigateButton(
                  onPressed: () async {
                    String result = await mapController.findCurrentLocation();
                    switch (result) {
                      case "Success":
                        showDelayedLoadingAnimation(
                            context, "assets/animations/loading.json", 160, 1);
                        break;
                      case "DeniedForever":
                        Get.dialog(AlertDialog(
                          title: const Text("Enable Location!"),
                          content: const Text(
                              "Please enable location services to access your location!"),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                geolocator.Geolocator.openLocationSettings();
                                Get.back();
                              },
                            )
                          ],
                        ));
                        break;
                      case "Denied":
                        CustomSnackBar.showCustomSnackBar(
                            context, "Vui lòng bật cài đặt vị trí",
                            duration: 2,
                            type: FlushbarType.info,
                            isShowOnTop: false);

                      default:
                        break;
                    }
                  },
                  iconData: CupertinoIcons.location,
                ),
                MapNavigateButton(
                  onPressed: () async {
                    await mapController.findRoute();
                  },
                  iconData: Icons.route,
                ),
              ],
            ),
          ),

          // Obx(
          //   () {
          //     if (mapController.isShow.value) {
          //       return Container(
          //         height: 120,
          //         margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colors.white),
          //         child: ListAddress(mapController: mapController),
          //       );
          //     }
          //     return const SizedBox.shrink();
          //   },
          // ),
          // //Text field địa chỉ
          // Container(
          //   height: 70.h,
          //   alignment: Alignment.topLeft,
          //   margin: const EdgeInsets.only(top: 30),
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: AddressTextField(
          //     bgColor: AppColors.white100,
          //     hintText: "Mời nhập địa chỉ",
          //     controller: mapController.searchController,
          //     onChanged: (text) async {
          //       if (text != null && text.isNotEmpty) {
          //         mapController.searchText.value = text;
          //         await mapController.predictLocation(text);
          //       } else {
          //         mapController.isShow.value = false;
          //         mapController.isHidden.value = true;
          //       }
          //     },
          //   ),
          // ),

          // Obx(
          //   () {
          //     if (!mapController.isHidden.value &&
          //         mapController.selectedLocation.value != null) {
          //       return AddressInfo(
          //         onChooseAddress: (selectedLocation) {
          //           if (onChooseAddress != null) {
          //             onChooseAddress!(selectedLocation);
          //           }
          //         },
          //         location: mapController.selectedLocation.value!,
          //       );
          //     }
          //     return const SizedBox.shrink();
          //   },
          // ),
        ],
      ),
    );
  }
}

// class ArcPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path orangeArc = Path()
//       ..moveTo(0, 0)
//       ..lineTo(0, size.height - 170)
//       ..quadraticBezierTo(
//           size.width / 2, size.height, size.width, size.height - 170)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, 0)
//       ..close();

//     canvas.drawPath(orangeArc, Paint()..color = Colors.orange);

//     Path whiteArc = Path()
//       ..moveTo(0.0, 0.0)
//       ..lineTo(0.0, size.height - 185)
//       ..quadraticBezierTo(
//           size.width / 2, size.height - 70, size.width, size.height - 185)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, 0)
//       ..close();

//     canvas.drawPath(whiteArc, Paint()..color = Colors.white);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

class MapNavigateButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData iconData;
  const MapNavigateButton({
    super.key,
    this.onPressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: AppColors.orange100, // Make the button circular
          padding: const EdgeInsets.all(18),
        ),
        child: Icon(
          iconData,
          size: 22,
          color: AppColors.white100,
        ),
      ),
    );
  }
}

// class _DotIndicator extends StatelessWidget {
//   final bool isSelected;

//   const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 6.0),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         height: 6.0,
//         width: 6.0,
//       ),
//     );
//   }
// }

// class OnboardingModel {
//   final String lottieFile;
//   final String title;
//   final String subtitle;

//   OnboardingModel(this.lottieFile, this.title, this.subtitle);
// }

// List<OnboardingModel> tabs = [
//   OnboardingModel(
//     'assets/delivery.json',
//     'Xin chào huynhphuocdat2 !',
//     'Hãy bắt đầu vận chuyển các đơn hàng nhé,\n khách hàng đang hóng bạn tới lắm ! \n Đến ngay nào hihi... ',
//   ),
// ];
