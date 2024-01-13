import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/controller/layout/layout_cubit.dart';
import 'package:kafiil/shared/constant.dart';
import 'package:number_paginator/number_paginator.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          body: cubit.countriesModel != null
              ? SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: Text(
                              'Countries',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10.r),
                            elevation: 2,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.h, horizontal: 6.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 322.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Country',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: const Color(0xFF696F79)),
                                        ),
                                        SizedBox(
                                          width: 133.w,
                                        ),
                                        Text(
                                          'Capital',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: const Color(0xFF696F79)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 115.w,
                                                  child: Text(
                                                      maxLines: 2,
                                                      cubit.countriesModel!
                                                          .data![index].name!,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                      )),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: 115.w,
                                                  child: Text(
                                                      maxLines: 2,
                                                      cubit
                                                          .countriesModel!
                                                          .data![index]
                                                          .capital!,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                      itemCount:
                                          cubit.countriesModel!.data!.length),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          NumberPaginator(
                            numberPages:
                                cubit.countriesModel!.pagination!.totalPages!,
                            onPageChange: (int index) {
                              cubit.getCountries(
                                  'https://test.kafiil.com/api/test/country?page=$index');
                            },
                            // initially selected index
                            initialPage:
                                cubit.countriesModel!.pagination!.currentPage!-1,
                            config: NumberPaginatorUIConfig(
                              // default height is 48
                              buttonShape: RoundedRectangleBorder(
                                side:
                                    const BorderSide(color: Color(0xFFE6EAEF)),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              buttonSelectedForegroundColor:
                                  const Color((0xFF333333)),
                              buttonUnselectedForegroundColor:
                                  const Color(0xFFC3C5C8),
                              buttonUnselectedBackgroundColor: Colors.white,
                              buttonSelectedBackgroundColor: Colors.white,
                            ),
                          )
                        ],
                      ),
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
}
