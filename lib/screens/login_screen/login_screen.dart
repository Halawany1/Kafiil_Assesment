import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kafiil/controller/authentication/authentication_cubit.dart';
import 'package:kafiil/screens/layout_screen/layout_screen.dart';
import 'package:kafiil/screens/register_screen/register_screen.dart';
import 'package:kafiil/shared/component/box_for_empry_validate.dart';
import 'package:kafiil/shared/component/elevated_button.dart';
import 'package:kafiil/shared/component/text_form_field.dart';
import 'package:kafiil/shared/constant.dart';
import 'package:kafiil/shared/network/local/caching_data.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: token, value: state.loginModel.accessToken);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LayoutScreen(),));
        }
        if (state is LoginFailedState) {
          var cubit = context.read<AuthenticationCubit>();
          cubit.validation(state.error);
        }
        if (state is SignUpSuccessState) {
          final snackbar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: primaryColor,
            content: Text('Successfully Register, Login Now',
              style: GoogleFonts.montserrat
                (fontSize: 12.sp, color: Colors.white),),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Text(
                'Account Login',
                style:
                GoogleFonts.montserrat(
                    fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Login-cuate 1.png'),
                    if(cubit.validate != '')
                      BoxEmptyValidate(text: cubit.validate),
                    SizedBox(height: 15.h,),
                    Column(
                      children: [
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
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.9,
                              child: Checkbox(
                                activeColor: primaryColor,
                                side: const BorderSide(
                                    color: Color(0xFFC3C5C8,), width: 2),
                                value: cubit.checkBox,
                                onChanged: (value) {
                                  cubit.changeCheckBox(value!);
                                },
                              ),
                            ),
                            Text(
                              'Remember me',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.sp, color: textColor),
                            ),
                            const Spacer(),
                            Text(
                              'Forgot Password?',
                              style: GoogleFonts.montserrat(fontSize: 12.sp,
                                  color: textColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        BuildElevatedButton(text: 'Login',
                          loading: state is LoadingLoginState ? true : false,
                          height: 56.h,
                          onPress: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              cubit.validation('Fill the required fields');
                            }
                            else if (!RegExp(
                                r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                .hasMatch(emailController.text)) {
                              cubit.validation('Please enter a valid email');
                            }
                            else if (passwordController.text.length < 8) {
                              cubit.validation(
                                  'Password must be at least 8 characters');
                            }
                            else {
                              cubit.validate = '';
                              cubit.userLogin(email: emailController.text,
                                  password: passwordController.text);
                            }
                          },),
                      ],
                    ),
                    SizedBox(height: 18.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t have an account ?',
                          style: GoogleFonts.montserrat(fontSize: 14.sp,
                              color: textColor),),
                        TextButton(
                          child: Text('Register',
                            style: GoogleFonts.montserrat(fontSize: 14.sp,
                                color: primaryColor),),
                          onPressed: () {
                            cubit.validate = '';
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),));
                          },
                        ),
                      ],),
                    SizedBox(height: 30.h,)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
