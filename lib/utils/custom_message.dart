import 'package:dat_delivery/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> showConfirmDialog(
    BuildContext context, String title, String confirmMessage) async {
  bool confirm = false;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            style: GoogleFonts.roboto(fontSize: 16),
          ),
          content: Text(
            confirmMessage,
            style: GoogleFonts.roboto(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text(
                "Huỷ",
                style: GoogleFonts.roboto(fontSize: 16.r),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                "OK",
                style: GoogleFonts.roboto(
                    fontSize: 16.r, color: AppColors.orange100),
              ),
              onPressed: () {
                confirm = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });

  return confirm;
}
