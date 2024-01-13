import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/controller/authentication/authentication_cubit.dart';

class BuildTextFormField extends StatelessWidget {
  final String text;
  final bool suffixIcon;
  final bool obscureText;
  final TextEditingController ?controller;
  final double width;
  final int numberOfFieldPass;
  final int maxLenght;
  final int maxLines;
  final bool birthdate;
  final bool readOnly;
  final String ?hintText;
  final VoidCallback ?onTap;
  const BuildTextFormField({
    super.key,
    required this.text,
    this.readOnly=false,
    this.onTap,
    this.hintText,
    this.birthdate = false,
    this.maxLines = 1,
    required this.maxLenght,
    this.suffixIcon = false,
     this.controller,
    this.numberOfFieldPass = 1,
    this.width = double.infinity,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF696F79)),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: width,
              child: TextFormField(
                onTap: onTap,
                readOnly: readOnly,
                maxLines: maxLines,
                maxLength: maxLenght,
                style: TextStyle(
                  fontSize:15.sp,
                ),
                controller: controller,
                obscureText: suffixIcon
                    ? numberOfFieldPass == 1
                        ? cubit.obscureOne
                        : cubit.obscureTwo
                    : false,
                decoration: InputDecoration(
                  hintText:readOnly?hintText:null ,
                    hintStyle:readOnly? GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: const Color(0xFF333333),
                      fontWeight: FontWeight.w500,
                    ):null,
                    counterText: '',
                    suffixIcon:
                    birthdate
                        ? InkWell(
                      onTap: onTap,
                          child: const Icon(Icons.date_range_outlined,
                              color: Color(0xFF8692A6)),
                        )
                        : suffixIcon
                            ? IconButton(
                                onPressed: () {
                                  if(!readOnly){
                                    cubit.changeVisibalityPassword(
                                        numberOfFieldPass);
                                  }

                                },
                                icon: numberOfFieldPass == 1
                                    ? Icon(
                                        !cubit.obscureOne
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: const Color(0xFF8692A6))
                                    : Icon(
                                        !cubit.obscureTwo
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: const Color(0xFF8692A6)),
                              )
                            : null,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16.r)),
                    fillColor: const Color(0xFFF9F9F9)),
              ),
            )
          ],
        );
      },
    );
  }
}
