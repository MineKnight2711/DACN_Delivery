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
        ],
      ),
    );
  }
}

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
