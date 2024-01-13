import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafiil/models/coountries_model.dart';
import 'package:kafiil/models/services_model.dart';
import 'package:kafiil/models/who_am_i_model.dart';
import 'package:kafiil/screens/countries/countries_screen.dart';
import 'package:kafiil/screens/services/services_screen.dart';
import 'package:kafiil/screens/who_am_i/who_am_screen.dart';
import 'package:kafiil/shared/constant.dart';
import 'package:kafiil/shared/network/local/caching_data.dart';
import 'package:kafiil/shared/network/remote/dio_helper.dart';
import 'package:kafiil/shared/network/remote/end_point.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Services'),
    BottomNavigationBarItem(icon: Icon(Icons.language), label: 'Countries'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_circle), label: 'Who Am I'),
  ];
  List<Widget> screenItem = const [
  ServicesScreen(),
    CountriesScreen(),
    WhoAmIScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  WhoAmModel? whoAmModel;

  void getUserData() {
    emit(LoadingUserDataState());
    print(CacheHelper.getData(key: token));
    DioHelper.getData(url: profile, token: CacheHelper.getData(key: token))
        .then((value) {
      print(value.data);
      whoAmModel = WhoAmModel.fromJson(value.data);
      emit(SuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUserDataState(error.toString()));
    });
  }


  List<DataServices> services = [];
  List<DataServices> servicesPopular = [];

  void geServices() {
    emit(LoadingServicesDataState());
    DioHelper.getData(
      url: service,
    ).then((value) {
      print(value.data);
      ServicesModel servicesModel = ServicesModel.fromJson(value.data);
      for (var element in servicesModel.data!) {
        services.add(element);
      }
      print('---------------------------------');
      print(services[0].title);
      emit(SuccessServicesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorServicesDataState(error.toString()));
    });
  }

  void gePopularServices() {
    emit(LoadingServicesPopularDataState());
    DioHelper.getData(url: popular).
    then((value) {
      print(value.data);
      ServicesModel servicesModel = ServicesModel.fromJson(value.data);
      for (var element in servicesModel.data!) {
        servicesPopular.add(element);
      }
     print(servicesPopular[0].title);
      emit(SuccessServicesPopularDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorServicesPopularDataState(error.toString()));
    });
  }

  CountriesModel? countriesModel;
  void getCountries(String url) async{
    emit(LoadingCountriesDataState());
    Dio dio=Dio();
    await dio.get(
      url,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Accept-Language": "en",
        },
      ),
    ). then((value) {
      print(value.data);
      countriesModel = CountriesModel.fromJson(value.data);
      emit(SuccessCountriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCountriesDataState(error.toString()));
    });

  }

}
