import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/shared/constant.dart';

class BuildElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onPress;
  final bool loading;
  const BuildElevatedButton({super.key,
  required this.text,
    required this.onPress,
  required this.height,
    this.loading=false,
    this.width=double.infinity
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)
            ),
            backgroundColor: primaryColor,
            minimumSize: Size(width, height)),
        child: loading?const CircularProgressIndicator(color: Colors.white,):
        Text(
          text,
          style: GoogleFonts.montserrat(color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp),
        ));
  }
}
