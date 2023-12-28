// ignore_for_file: use_build_context_synchronously

import 'package:dat_delivery/controller/order_controller.dart';
import 'package:dat_delivery/screens/screens/order/components/delivery_item.dart';
import 'package:dat_delivery/utils/custom_message.dart';
import 'package:dat_delivery/utils/custom_snackbar.dart';
import 'package:dat_delivery/utils/no_glowing_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final orderController = Get.find<OrderController>();
  void onChangedtabListener() {
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        int index = _tabController.index;
        print(orderController.tabs[index]);
        orderController.getOrderByStatus(orderController.tabs[index]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    onChangedtabListener();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.delete<OrderController>();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý đơn hàng'),
          backgroundColor: const Color.fromARGB(255, 243, 114, 63),
        ),
        body: RefreshIndicator(
          onRefresh: () => orderController.getDeliverOrder(),
          child: NoGlowingScrollView(
            child: SizedBox(
              height: 0.898.sh,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black, // Màu của tab được chọn
                    unselectedLabelColor:
                        Colors.grey, // Màu của các tab không được chọn
                    tabs: orderController.tabs
                        .map((tab) => Tab(
                              text: tab,
                            ))
                        .toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Obx(() {
                          if (orderController.listAsignedDetails.isNotEmpty) {
                            return Column(
                                children: orderController.listAsignedDetails
                                    .map((order) => DeliveryItem(
                                          buttonTitle: "Bắt đầu giao",
                                          onPressed: () async {
                                            bool comfirm =
                                                await showConfirmDialog(
                                                    context,
                                                    "Xác nhận",
                                                    "Bạn có muốn nhận đơn này?");
                                            if (comfirm) {
                                              final result = await orderController
                                                  .changeOrderStatus(
                                                      "${order.details?.order?.orderID}",
                                                      "Đang vận chuyển");
                                              if (result.message == "Success") {
                                                CustomSnackBar
                                                    .showCustomSnackBar(context,
                                                        "Nhận đơn thành công!",
                                                        duration: 2,
                                                        isShowOnTop: false,
                                                        type: FlushbarType
                                                            .success);
                                              } else {
                                                CustomSnackBar.showCustomSnackBar(
                                                    context,
                                                    "Có lỗi xảy ra!\nChi tiết:${result.data.toString()}",
                                                    duration: 2,
                                                    isShowOnTop: false,
                                                    type: FlushbarType.failure);
                                              }
                                            }
                                          },
                                          delivery: order,
                                        ))
                                    .toList());
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                        Obx(() {
                          if (orderController
                              .listOnDeliveryDetails.isNotEmpty) {
                            return Column(
                                children: orderController.listOnDeliveryDetails
                                    .map((order) => DeliveryItem(
                                          buttonTitle: "Xác nhận hoàn tất",
                                          delivery: order,
                                          onPressed: () async {
                                            bool comfirm = await showConfirmDialog(
                                                context,
                                                "Xác nhận",
                                                "Bạn có muốn hoàn tất đơn này?");
                                            if (comfirm) {
                                              final deliveryResult =
                                                  await orderController
                                                      .completeDelivery(
                                                          "${order.delivery?.deliveryId}");
                                              if (deliveryResult.message ==
                                                  "Success") {
                                                final result = await orderController
                                                    .changeOrderStatus(
                                                        "${order.details?.order?.orderID}",
                                                        "Đã hoàn tất");
                                                if (result.message ==
                                                    "Success") {
                                                  CustomSnackBar
                                                      .showCustomSnackBar(
                                                          context,
                                                          "Giao hàng thành công!",
                                                          duration: 2,
                                                          isShowOnTop: false,
                                                          type: FlushbarType
                                                              .success);
                                                } else {
                                                  CustomSnackBar.showCustomSnackBar(
                                                      context,
                                                      "Có lỗi xảy ra!\nChi tiết:${result.data.toString()}",
                                                      duration: 2,
                                                      isShowOnTop: false,
                                                      type:
                                                          FlushbarType.failure);
                                                }
                                              } else {
                                                CustomSnackBar.showCustomSnackBar(
                                                    context,
                                                    "Có lỗi xảy ra!\nChi tiết:${deliveryResult.data.toString()}",
                                                    duration: 2,
                                                    isShowOnTop: false,
                                                    type: FlushbarType.failure);
                                              }
                                            }
                                          },
                                        ))
                                    .toList());
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                        Obx(() {
                          if (orderController.listDeliveredDetails.isNotEmpty) {
                            return Column(
                                children: orderController.listDeliveredDetails
                                    .map((order) => DeliveryItem(
                                          buttonTitle: "Báo cáo",
                                          onPressed: () {},
                                          delivery: order,
                                        ))
                                    .toList());
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
