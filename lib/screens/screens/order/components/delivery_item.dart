import 'package:dat_delivery/config/font.dart';
import 'package:dat_delivery/model/delivery_dto_model.dart';
import 'package:dat_delivery/screens/screens/order/components/order_details_bottom_sheet.dart';
import 'package:dat_delivery/utils/data_convert.dart';
import 'package:dat_delivery/utils/no_glowing_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryItem extends StatelessWidget {
  final DeliveryDTO delivery;
  final String buttonTitle;
  final Function()? onPressed;
  const DeliveryItem(
      {super.key,
      required this.delivery,
      required this.buttonTitle,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            _showBottomSheet(
                delivery.details?.order, context, buttonTitle, onPressed);
          },
          leading: Image.asset(
            "assets/image/delivery-man.png",
            width: 25.w,
          ),
          title: Text(
            "Mã vận đơn : ${delivery.delivery?.deliveryId}",
            style: CustomFonts.customGoogleFonts(fontSize: 14.r),
          ),
          subtitle: Text(
              "Ngày giao đơn ${DataConvert().formattedOrderDate(delivery.delivery?.dateAccepted)}"),
        ),
        Divider(
          height: 5.h,
          thickness: 1.w,
          endIndent: 10.w,
          indent: 10.w,
        ),
      ],
    );
  }

  void _showBottomSheet(OrderModel? order, BuildContext context,
      String buttonTitle, Function()? onPressed) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6, //Kích cỡ sheet khi vừa hiện lên
          minChildSize:
              0.3, //Khi ta kéo sheet về 0.3 chiều cao của nó, nó sẽ đóng
          maxChildSize: 0.95, //Chiều cao tối đa của sheet được phép kéo lên
          expand: false,
          builder: (context, scrollController) {
            return NoGlowingScrollView(
              scrollController: scrollController,
              child: OrderDetailsBottomSheet(
                scrollController: scrollController,
                order: order,
                onPressed: onPressed,
                buttonTitle: buttonTitle,
              ),
            );
          },
        );
      },
    );
  }
}
