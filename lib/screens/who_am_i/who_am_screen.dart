import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/controller/layout/layout_cubit.dart';
import 'package:kafiil/screens/login_screen/login_screen.dart';
import 'package:kafiil/screens/register_screen/register_screen.dart';
import 'package:kafiil/shared/component/elevated_button.dart';
import 'package:kafiil/shared/component/text_form_field.dart';
import 'package:kafiil/shared/constant.dart';
import 'package:kafiil/shared/network/local/caching_data.dart';

class WhoAmIScreen extends StatelessWidget {
  const WhoAmIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var pass = TextEditingController();
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        pass.text = "****************";
        var cubit = context.read<LayoutCubit>();
        return Scaffold(

          body: cubit.whoAmModel != null
              ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Text(
                        'Who Am I',
                        style: GoogleFonts.montserrat(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 75.w,
                            height: 75.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.r),
                                border: Border.all(color: primaryColor)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35.r),
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  cubit.whoAmModel!.data!.avatar!),
                            )),
                        SizedBox(
                          height: 32.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Row(
                      children: [
                        BuildTextFormField(
                          readOnly: true,
                          hintText: cubit.whoAmModel!.data!.firstName,
                          maxLenght: 50,
                          width: 160.w,
                          text: 'First Name',
                        ),
                        const Spacer(),
                        BuildTextFormField(
                          readOnly: true,
                          hintText: cubit.whoAmModel!.data!.lastName,
                          maxLenght: 50,
                          width: 160.w,
                          text: 'Last Name',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    BuildTextFormField(
                      readOnly: true,
                      hintText: cubit.whoAmModel!.data!.email,
                      maxLenght: 64,
                      text: 'Email Address',
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    BuildTextFormField(
                      readOnly: true,
                      maxLenght: 300,
                      obscureText: true,
                      controller: pass,
                      numberOfFieldPass: 1,
                      suffixIcon: true,
                      text: 'Password',
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'User Type',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: textColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 118.w,
                          child: RadioListTile<UserType>(
                            title: Text(
                              'Seller',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            value: UserType.seller,
                            activeColor: primaryColor,
                            groupValue: cubit
                                .whoAmModel!.data!.type!.code ==
                                3
                                ? UserType.both
                                : cubit.whoAmModel!.data!.type!.code == 1
                                ? UserType.buyer
                                : UserType.seller,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (UserType? value) {},
                          ),
                        ),
                        SizedBox(
                          width: 110.w,
                          child: RadioListTile<UserType>(
                            title: Text(
                              'Buyer',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            value: UserType.buyer,
                            activeColor: primaryColor,
                            contentPadding: EdgeInsets.zero,
                            groupValue: cubit
                                .whoAmModel!.data!.type!.code ==
                                3
                                ? UserType.both
                                : cubit.whoAmModel!.data!.type!.code == 1
                                ? UserType.buyer
                                : UserType.seller,
                            onChanged: (UserType? value) {},
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: RadioListTile<UserType>(
                            title: Text(
                              'Both',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            value: UserType.both,
                            activeColor: primaryColor,
                            contentPadding: EdgeInsets.zero,
                            groupValue: cubit
                                .whoAmModel!.data!.type!.code ==
                                3
                                ? UserType.both
                                : cubit.whoAmModel!.data!.type!.code == 1
                                ? UserType.buyer
                                : UserType.seller,
                            onChanged: (UserType? value) {},
                          ),
                        ),
                      ],
                    ),
                    BuildTextFormField(
                        readOnly: true,
                        maxLines: 4,
                        maxLenght: 1000,
                        text: 'About',
                        hintText: cubit.whoAmModel!.data!.about),
                    SizedBox(
                      height: 15.h,
                    ),
                    BuildTextFormField(
                        readOnly: true,
                        maxLenght: 100,
                        text: 'Salary',
                        hintText: "SAR ${cubit.whoAmModel!.data!.salary}"),
                    SizedBox(
                      height: 15.h,
                    ),
                    BuildTextFormField(
                      birthdate: true,
                      hintText: cubit.whoAmModel!.data!.birthDate,
                      text: 'Birth Date',
                      maxLenght: 10,
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Gender',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: textColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 135.w,
                          child: RadioListTile<Gender>(
                            title: Text(
                              'Male',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            value: Gender.male,
                            activeColor: primaryColor,
                            groupValue: cubit.whoAmModel!.data!.gender == 0
                                ? Gender.male
                                : Gender.female,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (Gender? value) {},
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        SizedBox(
                          width: 135.w,
                          child: RadioListTile<Gender>(
                            title: Text(
                              'Female',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            value: Gender.female,
                            activeColor: primaryColor,
                            contentPadding: EdgeInsets.zero,
                            groupValue: cubit.whoAmModel!.data!.gender == 0
                                ? Gender.male
                                : Gender.female,
                            onChanged: (Gender? value) {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Skills',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: textColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 12.w),
                        alignment: Alignment.topLeft,
                        width: double.infinity,
                        height: 94.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: const Color(0xFFF9F9F9)),
                        child: GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.w,
                            mainAxisSpacing: 12.w,
                            mainAxisExtent: 30.h,
                          ),
                          itemBuilder: (context, index) {
                            return Chip(
                              onDeleted: () {

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.r)),
                              side: BorderSide.none,
                              deleteIcon: Icon(
                                Icons.close,
                                color: primaryColor,
                                size: 15.r,
                              ),
                              label: Text(
                                cubit.whoAmModel!.data!.tags![index].name!,
                                style: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor),
                              ),
                              backgroundColor: const Color(0xFFE9F9F1),
                            );
                          },
                          itemCount: cubit.whoAmModel!.data!.tags!.length,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Favourite Social Media',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: textColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: primaryColor,
                              side: const BorderSide(
                                  color: Color(0xFFC3C5C8), width: 2),
                              value: cubit.whoAmModel!.data!
                                  .favoriteSocialMedia!.
                              contains("facebook") ? true : false,
                              onChanged: (value) {},
                            ),
                            Image.asset('assets/images/path14.png'),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'Facebook',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                  color: Color(0xFFC3C5C8), width: 2),
                              activeColor: primaryColor,
                              value: cubit.whoAmModel!.data!
                                  .favoriteSocialMedia!.
                              contains("x") ? true : false,
                              onChanged: (value) {},
                            ),
                            Image.asset('assets/images/twitter.png'),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'Twitter',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                  color: Color(0xFFC3C5C8), width: 2),
                              activeColor: primaryColor,
                              value: cubit.whoAmModel!.data!
                                  .favoriteSocialMedia!.
                              contains("instagram") ? true : false,
                              onChanged: (value) {},
                            ),
                            Image.asset(
                              'assets/images/instagram.png',
                              scale: 23,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'Instagram',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    BuildElevatedButton(text: 'Sign Out',
                        onPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Confirm Sign Out',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: Text(
                                  'Are you sure you want to sign out?',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15.sp,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(false); // User chose to cancel
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.montserrat(
                                          color: primaryColor, fontSize: 15.sp),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      CacheHelper.removeData(key: token);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginScreen()));// User chose to confirm
                                    },
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.montserrat(
                                          color: primaryColor, fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        height: 56.h)
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
