import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil/controller/authentication/authentication_cubit.dart';
import 'package:kafiil/controller/layout/layout_cubit.dart';
import 'package:kafiil/screens/layout_screen/layout_screen.dart';
import 'package:kafiil/screens/login_screen/login_screen.dart';
import 'package:kafiil/shared/constant.dart';
import 'package:kafiil/shared/network/local/caching_data.dart';
import 'package:kafiil/shared/network/remote/dio_helper.dart';

import 'shared/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (context) => LayoutCubit()
            ..getUserData()
            ..geServices()
            ..gePopularServices()
          ..getCountries('https://test.kafiil.com/api/test/country'),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          home: CacheHelper.getData(key: token) != null
              ? const LayoutScreen()
              : const LoginScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
