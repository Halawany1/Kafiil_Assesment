import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/controller/layout/layout_cubit.dart';
import 'package:kafiil/shared/constant.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          body: cubit.services.isNotEmpty && cubit.servicesPopular.isNotEmpty
              ? SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: Text(
                            'Services',
                            style: GoogleFonts.montserrat(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          height: 192.h,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.none,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildServices(
                                  image: cubit.services[index].mainImage!,
                                  title: cubit.services[index].title!,
                                  averageRate:
                                      cubit.services[index].averageRating!,
                                  completeSalesCount: cubit
                                      .services[index].completedSalesCount!,
                                  price: cubit.services[index].price!),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 12.w,
                                  ),
                              itemCount: cubit.services.length),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: Text(
                            'Popular Services',
                            style: GoogleFonts.montserrat(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          height: 192.h,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.none,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildServices(
                                  image:
                                      cubit.servicesPopular[index].mainImage!,
                                  title: cubit.servicesPopular[index].title!,
                                  averageRate: cubit
                                      .servicesPopular[index].averageRating!,
                                  completeSalesCount: cubit
                                      .servicesPopular[index]
                                      .completedSalesCount!,
                                  price: cubit.servicesPopular[index].price!),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 12.w,
                                  ),
                              itemCount: cubit.services.length),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: primaryColor,
                )),
        );
      },
    );
  }

  Material buildServices({
    required String image,
    required int price,
    required int completeSalesCount,
    required int averageRate,
    required String title,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10.r),
      elevation: 2,
      shadowColor: const Color(0xFFC3C5C8),
      child: Container(
        width: 157.w,
        height: 192.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), color: Colors.white),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    fit: BoxFit.cover,
                    image,
                    width: 157.w,
                    height: 101.h,
                  ),
                ),
                Positioned(
                  left: 6.w,
                  bottom: 8.h,
                  child: Container(
                    alignment: Alignment.center,
                    width: 60.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.r),
                        color: const Color(0xFF1DBF73)),
                    child: Text(
                      "\$${price}",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                    fontSize: 11.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: const Color(0xFFFFCB31),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  '(${averageRate})',
                  style: GoogleFonts.montserrat(
                      color: const Color(0xFFFFCB31),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Container(
                  height: 10.h,
                  color: const Color(0xFFC3C5C8),
                  width: 1,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Image.asset(
                  'assets/images/Group.png',
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  '$completeSalesCount',
                  style: GoogleFonts.montserrat(
                      color: const Color(0xFF828282),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
