import 'package:dat_delivery/config/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawerHeader extends StatelessWidget {
  final String name;
  final String email;
  final ImageProvider<Object>? imageAvatar;
  const MyDrawerHeader({
    Key? key,
    required this.name,
    required this.email,
    required this.imageAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 243, 114, 63),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: imageAvatar,
          ),
          SizedBox(height: 8.w),
          Text(name, style: CustomFonts.customGoogleFonts(fontSize: 16.r)),
          SizedBox(height: 4.w),
          Text(email, style: CustomFonts.customGoogleFonts(fontSize: 16.r)),
        ],
      ),
    );
  }
}
