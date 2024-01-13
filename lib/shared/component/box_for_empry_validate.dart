import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxEmptyValidate extends StatelessWidget {
  final String text;
  const BoxEmptyValidate({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFFFF0ED),
          borderRadius: BorderRadius.circular(6.r)
      ),
      height: 35.h,
      child: Row(children: [
        Icon(Icons.info_outline,color: Colors.red,
          size: 15.w,),
        SizedBox(width: 5.w,),
        Text(text,
          style: GoogleFonts.montserrat(fontSize: 12.sp,color: Colors.red),)
      ],),
    );
  }
}
