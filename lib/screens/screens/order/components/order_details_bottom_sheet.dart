import 'package:dat_delivery/config/colors.dart';
import 'package:dat_delivery/config/font.dart';
import 'package:dat_delivery/model/delivery_dto_model.dart';
import 'package:dat_delivery/utils/custom_button.dart';
import 'package:dat_delivery/utils/data_convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final OrderModel? order;
  final ScrollController? scrollController;
  final Function()? onPressed;
  final String buttonTitle;
  const OrderDetailsBottomSheet({
    super.key,
    required this.order,
    this.scrollController,
    this.onPressed,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OrderDetailsBottomSheetHeader(),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mã đơn hàng",
                textAlign: TextAlign.center,
                style: CustomFonts.customGoogleFonts(
                  fontSize: 14.r,
                  color: AppColors.dark20,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "${order?.orderID}",
                textAlign: TextAlign.center,
                style: CustomFonts.customGoogleFonts(
                  fontSize: 16.r,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 30.h,
          thickness: 3.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trạng thái đơn hàng",
                textAlign: TextAlign.center,
                style: CustomFonts.customGoogleFonts(
                  fontSize: 14.r,
                  color: AppColors.dark20,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "${order?.status}",
                textAlign: TextAlign.center,
                style: CustomFonts.customGoogleFonts(
                  fontSize: 16.r,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 20.h,
          thickness: 3.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Thông tin đơn hàng",
                style: CustomFonts.customGoogleFonts(fontSize: 16.r),
              ),
              SizedBox(
                height: 15.h,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Người nhận",
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r, color: AppColors.dark20),
                        ),
                        Text(
                          '${(order?.deliveryInfo?.split("|")[1])?.split(",")[0]}',
                          style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 40,
                      width: 0.8,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    right: 90,
                    child: Column(
                      children: [
                        Text(
                          "Số điện thoại",
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r, color: AppColors.dark20),
                        ),
                        Text(
                          '${(order?.deliveryInfo?.split("|")[1])?.split(",")[1]}',
                          style: CustomFonts.customGoogleFonts(
                            fontSize: 14.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20.h,
                thickness: 1.h,
              ),
              Text(
                "Địa chỉ nhận",
                style: CustomFonts.customGoogleFonts(
                    fontSize: 14.r, color: AppColors.dark20),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "${order?.deliveryInfo?.split("|")[0]}",
                style: CustomFonts.customGoogleFonts(fontSize: 15.r),
              ),
            ],
          ),
        ),
        Divider(
          height: 20.h,
          thickness: 3.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              order?.voucher != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ưa đãi sử dụng",
                              style: CustomFonts.customGoogleFonts(
                                fontSize: 14.r,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "${order?.voucher?.voucherName}",
                              style: CustomFonts.customGoogleFonts(
                                fontSize: 14.r,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          order?.voucher?.type == "Percent"
                              ? "${order?.voucher?.discountPercent}%"
                              : order?.voucher?.type == "Amount"
                                  ? "- ${DataConvert().formatCurrency(order?.voucher?.discountAmount ?? 0)}"
                                  : "",
                          style: CustomFonts.customGoogleFonts(
                            fontSize: 14.r,
                          ),
                        ),
                      ],
                    )
                  : const Card(),
              order?.voucher != null
                  ? Divider(
                      height: 25.h,
                      thickness: 1.h,
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: 30.h,
              ),
              Container(
                alignment: Alignment.center,
                height: 50.h,
                child: RoundIconButton(
                    size: 80.r, title: buttonTitle, onPressed: onPressed),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderDetailsBottomSheetHeader extends StatelessWidget {
  const OrderDetailsBottomSheetHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              "Chi tiết đơn hàng",
              textAlign: TextAlign.center,
              style: CustomFonts.customGoogleFonts(fontSize: 16.r),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
