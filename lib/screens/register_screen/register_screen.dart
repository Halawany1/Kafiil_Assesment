import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/controller/authentication/authentication_cubit.dart';
import 'package:kafiil/screens/login_screen/login_screen.dart';
import 'package:kafiil/shared/component/box_for_empry_validate.dart';
import 'package:kafiil/shared/component/elevated_button.dart';
import 'package:kafiil/shared/component/text_form_field.dart';
import 'package:kafiil/shared/constant.dart';

enum UserType { seller, buyer, both }

enum Gender { male, female }

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var aboutController = TextEditingController();
    var birthDateController = TextEditingController();

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is SignUpSuccessState){
          var cubit=context.read<AuthenticationCubit>();
          cubit.facebookChecked = false;
          cubit.twitterChecked = false;
          cubit.instagramChecked = false;
          cubit.currentRigesterScreen = 1;
          cubit.salary = 1000;
          cubit.selectedGender = null;
          cubit.image=null;
          cubit.selectedUserType = null;
         Navigator.pop(context);
        }
        if(state is SignUpFailedState){
          final snackbar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('There is Invalid Data',
              style: GoogleFonts.montserrat
                (fontSize: 12.sp,color: Colors.white),),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          appBar: buildAppBar(context, cubit),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (cubit.validate != '')
                      BoxEmptyValidate(text: cubit.validate),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 52.w),
                      child: Row(
                        children: [
                          Text(
                            'Register',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp, color: primaryColor),
                          ),
                          SizedBox(
                            width: 86.w,
                          ),
                          Text(
                            'Complete Data',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                color: cubit.currentRigesterScreen == 1
                                    ? const Color(0xFFC3C5C8)
                                    : primaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //check current register screen
                    buildRowSteps(cubit),
                    SizedBox(
                      height: 35.h,
                    ),
                    if (cubit.currentRigesterScreen == 1)
                      buildFirstScreen(
                          firstNameController,
                          lastNameController,
                          emailController,
                          passwordController,
                          confirmPasswordController,
                          cubit),
                    if (cubit.currentRigesterScreen == 2)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  cubit.image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(35.r),
                                    child: Image.file(
                                      cubit.image!,
                                      height: 75.w,
                                      width: 75.w,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Image.asset(
                                      'assets/images/Clipped-1.png'),
                                  InkWell(
                                    onTap: () {
                                      cubit.pickImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 11.r,
                                      backgroundColor: primaryColor,
                                      child: Icon(
                                        Icons.add,
                                        size: 18.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildTextFormField(
                              maxLines: 4,
                              maxLenght: 1000,
                              text: 'About',
                              controller: aboutController),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Salary',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          buildSalaryContainer(cubit),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildTextFormField(
                            onTap: () {
                              cubit.selectDate(context);
                            },
                              birthdate: true,
                              text: 'Birth Date',
                              readOnly: true,
                              maxLenght: 10,
                              controller: cubit.dateController),
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
                                  groupValue: cubit.selectedGender,
                                  contentPadding: EdgeInsets.zero,
                                  onChanged: (Gender? value) {
                                    cubit.selectGender(value!);
                                  },
                                ),
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
                                  groupValue: cubit.selectedGender,
                                  onChanged: (Gender? value) {
                                    cubit.selectGender(value!);
                                  },
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
                                  return InkWell(
                                    onTap: cubit.checkSkill[index] == true
                                        ? null
                                        : () {
                                      cubit.checkSkills(index);
                                    },
                                    child: Chip(
                                      onDeleted: cubit.checkSkill[index] == true
                                          ? () {
                                        cubit.checkSkills(index);
                                      }
                                          : null,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.r)),
                                      side: BorderSide.none,
                                      deleteIcon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15.r,
                                      ),
                                      label: Text(
                                        cubit.skills[index],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                            cubit.checkSkill[index] == true
                                                ? Colors.white
                                                : primaryColor),
                                      ),
                                      backgroundColor:
                                      cubit.checkSkill[index] == true
                                          ? primaryColor
                                          : const Color(0xFFE9F9F1),
                                    ),
                                  );
                                },
                                itemCount: cubit.skill.length,
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
                                    value: cubit.facebookChecked,
                                    onChanged: (value) {
                                      cubit.changeCheckbox(1);
                                    },
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
                                    value: cubit.twitterChecked,
                                    onChanged: (value) {
                                      cubit.changeCheckbox(2);
                                    },
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
                                    value: cubit.instagramChecked,
                                    onChanged: (value) {
                                      cubit.changeCheckbox(3);
                                    },
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
                          )
                        ],
                      ),
                    SizedBox(
                      height: 50.h,
                    ),
                    BuildElevatedButton(
                      loading: cubit.currentRigesterScreen==2&&state is LoadingSignUpState?true:false,
                      text: cubit.currentRigesterScreen == 1 ? 'Next' : 'Submit',
                      height: 56.h,
                      width: cubit.currentRigesterScreen == 1 ? 160.w : double.infinity,
                      onPress: () {

                        if (cubit.currentRigesterScreen == 1) {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              confirmPasswordController.text.isEmpty) {
                            cubit.validation('Fill the required fields');
                          } else if (cubit.selectedUserType == null) {
                            cubit.validation('You must select User Type');
                          } else if (!RegExp(
                              r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                              .hasMatch(emailController.text)) {
                            cubit.validation('Please enter a valid email');
                          } else if (passwordController.text.length < 8) {
                            cubit.validation('Password must be at least 8 characters');
                          } else if (confirmPasswordController.text !=
                              passwordController.text) {
                            cubit.validation('Passwords do not match');
                          }
                          else {
                            cubit.validate = '';
                            cubit.changeCurrentRigester(2);
                          }
                        } else {
                          List<int>tags=[];
                          List<String>socail=[];
                          for(int i=0;i<cubit.skill.length;i++){
                            if(cubit.checkSkill[i]==true){
                              tags.add(cubit.skill[i]);
                            }
                          }
                          if(cubit.facebookChecked==true){
                            socail.add("facebook");
                          }
                          if(cubit.twitterChecked==true){
                            socail.add("x");
                          }
                          if(cubit.instagramChecked==true){
                            socail.add("instagram");
                          }
                          final RegExp birthdateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                          // Year-Month-Day format
                          if (aboutController.text.isEmpty ||
                              cubit.dateController.text.isEmpty) {
                            cubit.validation('Fill the required fields');
                          }
                          else if(cubit.image==null){
                            cubit.validation('You must to set profile image');
                          }
                          else if (cubit.selectedGender == null) {
                            cubit.validation('You must select Gender');
                          } else if(tags.isEmpty){
                            cubit.validation('You must select at least one skill');
                          }
                          else if (!cubit.instagramChecked &&
                              !cubit.twitterChecked &&
                              !cubit.facebookChecked) {
                            cubit.validation('You must select at least one social media');
                          } else if (aboutController.text.length < 10) {
                            cubit.validation('About must be at least 10 characters');
                          }
                          else {
                            cubit.validation('');
                            cubit.userRigester(email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                about: aboutController.text,
                                birthDate: cubit.dateController.text,
                                gender: cubit.selectedGender == Gender.male ? 0 : 1,
                                userType: cubit.selectedUserType == UserType.buyer ? 1 : cubit
                                    .selectedUserType == UserType.seller ? 2 : 3,
                                tags: tags,
                                avatar: cubit.image!,
                                salary: cubit.salary,
                                socail: socail);
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Container buildSalaryContainer(AuthenticationCubit cubit) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: const Color(0xFFF9F9F9)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              cubit.changeSalary(false);
            },
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(16.r),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 14.r,
                child: Icon(
                  Icons.remove,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 62.w,
          ),
          Text(
            'SAR ${cubit.salary}',
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 62.w,
          ),
          InkWell(
            onTap: () {
              cubit.changeSalary(true);
            },
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(16.r),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 14.r,
                child: Icon(
                  Icons.add,
                  color: primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, AuthenticationCubit cubit) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(top: 15.h, left: 20.h),
        child: IconButton(
          onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildAlertDialog(context, cubit);
                },
              );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Text(
          'Register',
          style: GoogleFonts.montserrat(
              fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, AuthenticationCubit cubit) {
    return AlertDialog(
                title:const  Text(
                  'Confirm Action',
                  style: TextStyle(color: Colors.red),
                ),
                content: Text(
                  'All thing will be Removed',
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
                      cubit.facebookChecked = false;
                      cubit.twitterChecked = false;
                      cubit.instagramChecked = false;
                      cubit.currentRigesterScreen = 1;
                      cubit.salary = 1000;
                      cubit.selectedGender = null;
                      cubit.image=null;
                      cubit.selectedUserType = null;
                      cubit.dateController.clear();
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pop(true);
                      for(int i=0;i<cubit.checkSkill.length;i++)
                        {
                          cubit.checkSkill[i]=false;
                        }
                     // User chose to confirm
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.montserrat(
                          color: primaryColor, fontSize: 15.sp),
                    ),
                  ),
                ],
              );
  }

  Row buildRowSteps(AuthenticationCubit cubit) {
    return Row(
      children: [
        Container(
          width: 65.w,
          height: 2.h,
          color: primaryColor,
        ),
        Container(
          width: 24.w,
          height: 24.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: cubit.currentRigesterScreen == 1
                  ? Colors.white
                  : primaryColor,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: primaryColor, width: 2.w)),
          child: cubit.currentRigesterScreen == 1
              ? Text(
            '1',
            style: GoogleFonts.montserrat(
                fontSize: 12.sp, color: primaryColor),
          )
              : const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
        Container(
          width: 135.w,
          height: 2.h,
          color: cubit.currentRigesterScreen == 1
              ? const Color(0xFFE6EAEF)
              : primaryColor,
        ),
        if (cubit.currentRigesterScreen == 1)
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE6EAEF),
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
        if (cubit.currentRigesterScreen == 2)
          Container(
            width: 24.w,
            height: 24.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: primaryColor, width: 2.w)),
            child: Text(
              '2',
              style:
              GoogleFonts.montserrat(fontSize: 12.sp, color: primaryColor),
            ),
          ),
        Container(
          width: 75.w,
          height: 2.h,
          color: const Color(0xFFE6EAEF),
        ),
      ],
    );
  }



  Column buildFirstScreen(TextEditingController firstNameController,
      TextEditingController lastNameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController,
      AuthenticationCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BuildTextFormField(
              maxLenght: 50,
              width: 160.w,
              controller: firstNameController,
              text: 'First Name',
            ),
            const Spacer(),
            BuildTextFormField(
              maxLenght: 50,
              width: 160.w,
              controller: lastNameController,
              text: 'Last Name',
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        BuildTextFormField(
          maxLenght: 64,
          controller: emailController,
          text: 'Email Address',
        ),
        SizedBox(
          height: 15.h,
        ),
        BuildTextFormField(
          maxLenght: 300,
          numberOfFieldPass: 1,
          suffixIcon: true,
          controller: passwordController,
          text: 'Password',
        ),
        SizedBox(
          height: 12.h,
        ),
        BuildTextFormField(
          maxLenght: 300,
          numberOfFieldPass: 2,
          suffixIcon: true,
          controller: confirmPasswordController,
          text: 'Confirm Password',
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'User Type',
          style: GoogleFonts.montserrat(
              fontSize: 12.sp, fontWeight: FontWeight.w500, color: textColor),
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
                      fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                value: UserType.seller,
                activeColor: primaryColor,
                groupValue: cubit.selectedUserType,
                contentPadding: EdgeInsets.zero,
                onChanged: (UserType? value) {
                  cubit.selectUserType(value!);
                },
              ),
            ),
            SizedBox(
              width: 110.w,
              child: RadioListTile<UserType>(
                title: Text(
                  'Buyer',
                  style: GoogleFonts.montserrat(
                      fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                value: UserType.buyer,
                activeColor: primaryColor,
                contentPadding: EdgeInsets.zero,
                groupValue: cubit.selectedUserType,
                onChanged: (UserType? value) {
                  cubit.selectUserType(value!);
                },
              ),
            ),
            SizedBox(
              width: 100.w,
              child: RadioListTile<UserType>(
                title: Text(
                  'Both',
                  style: GoogleFonts.montserrat(
                      fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                value: UserType.both,
                activeColor: primaryColor,
                contentPadding: EdgeInsets.zero,
                groupValue: cubit.selectedUserType,
                onChanged: (UserType? value) {
                  cubit.selectUserType(value!);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
