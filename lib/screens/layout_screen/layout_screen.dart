import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/controller/layout/layout_cubit.dart';
import 'package:kafiil/shared/constant.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      builder: (context, state) {
        var cubit=context.read<LayoutCubit>();
        return Scaffold(
          body: cubit.screenItem[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation:15,
            selectedLabelStyle:  GoogleFonts.montserrat(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color:Color(0xFFC3C5C8) ),
            unselectedIconTheme:const IconThemeData(
              color: Color(0xFFC3C5C8)
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color:Color(0xFFC3C5C8) ),
            selectedItemColor: primaryColor,
            onTap: (value) {
              cubit.changeBottomNavBar(value);
            },
            currentIndex: cubit.currentIndex,
            items:cubit.bottomItem ,
          ),
        );
      },
      listener: (context, state) {

      },
    );
  }
}
