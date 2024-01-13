
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kafiil/models/errors_model.dart';
import 'package:kafiil/models/user_model.dart';
import 'package:kafiil/screens/register_screen/register_screen.dart';
import 'package:kafiil/shared/constant.dart';
import 'package:kafiil/shared/network/remote/dio_helper.dart';
import 'package:kafiil/shared/network/remote/end_point.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());


  bool checkBox=false;
  void changeCheckBox(bool value){
    checkBox=value;
    emit(ChangeCheckBoxState());
  }

  String validate='';
  void validation(String valid){
    validate=valid;
    emit(ChangeValidateDataState());
  }

  bool obscureOne=true;
  bool obscureTwo=true;
  void changeVisibalityPassword(int numberOfPass){
    if(numberOfPass==1){
      obscureOne=!obscureOne;
    }else{
      obscureTwo=!obscureTwo;
    }
    emit(ChangeVisibalityState());
  }

  UserModel ?userModel;
  ErrorsModel ?errorsModel;
  void userLogin({
    required String email,
    required String password,
  }) async{
    emit(LoadingLoginState());
    try {
      final Response response = await DioHelper.postData(
          url: login,
          data: {'email': email, 'password': password});
      if(response.statusCode==200) {
        print(response.data.toString());
        Map<String, dynamic> responseData = response.data;
        userModel = UserModel.fromJson(responseData);
        emit(LoginSuccessState(userModel!));
      }
    } catch (error) {
      if (error is DioError) {
        if(error.response!.statusCode==522){
          Map<String, dynamic> responseData =
              error.response!.data;
          errorsModel = ErrorsModel.fromJson(responseData);
          print(error.response!.data.toString());
          emit(LoginFailedState(error:errorsModel!.message!));
        }else{
          print(error.toString());
          emit(LoginFailedState(error: "Invalid email or password"));
        }
      } else {
        print(error.toString());
        emit(LoginFailedState(error: 'there is Error'));
      }
    }
  }

  void userRigester({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String about,
    required String birthDate,
    required int gender,
    required int userType,
    required List<int>tags,
    required File avatar,
    required int salary,
    required List<String>socail
  }) async{

    emit(LoadingSignUpState());
    print(firstName);
    print(lastName);
    print(email);
    print(password);
    print(confirmPassword);
    print(tags);
    print(about);
    print(gender);
    print(birthDate);
    print(salary);
    print(socail);
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'first_name': firstName,
        'last_name': lastName,
        'about':about,
        'birth_date': birthDate,
        'gender': gender,
        'type': userType,
        'tags[]': tags,
        'avatar': await MultipartFile.fromFile(
          avatar.path,
          filename: avatar.path.split('/').last,
        ),
        'salary': salary,
        'favorite_social_media[]': socail,
      });
      final Response response = await dio.post(
      'https://test.kafiil.com/api/test/user/register',
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Accept-Language": "en",
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      if(response.statusCode==200) {
        emit(SignUpSuccessState());
      }
    } catch (error) {
      if (error is DioError) {
        if(error.response!.statusCode==522){
          print(error.response!.data.toString());
          emit(SignUpFailedState(error:error.response!.statusMessage.toString()));
        }else{
          print(error.message);
          emit(SignUpFailedState(error: "Invalid email or password"));
        }
      } else {
        print(error.toString());
        emit(SignUpFailedState(error: 'there is Error'));
      }
    }
  }



  UserType? selectedUserType;
void selectUserType(UserType value){
  selectedUserType=value;
    emit(ChangeRadioBoxState());
}

  Gender? selectedGender;
  void selectGender(Gender value){
    selectedGender=value;
    emit(ChangeRadioBoxState());
  }

int currentRigesterScreen=1;
void changeCurrentRigester(int current){
  currentRigesterScreen=current;
  emit(ChangeCurrentRigesterScreenState());
}
int salary=1000;
void changeSalary(bool add){
  if(add&&salary<10000){
    salary+=20;
  }else if(!add&&salary>120){
    salary-=20;
  }
  emit(ChangeSalaryState());
}

  bool facebookChecked = false;
  bool twitterChecked = false;
  bool instagramChecked = false;
  void changeCheckbox(int index){
    if(index==1){
      facebookChecked=!facebookChecked;
    }else if(index==2){
      twitterChecked=!twitterChecked;
    }else{
      instagramChecked=!instagramChecked;
    }
    emit(ChangeCheckBoxState());
  }
  Map<int,bool>checkSkill={
    1:false,
    2:false,
    3:false,
    4:false,
    5:false,
    6:false,
  };
  List<String>skills=["العروض التقديمية","Microsoft Word"
    ,"تصميم الشعارات","تصميم الجرافيك","CSS","كتابة المحتوى"];
  List<int>skill=[100,5,6,7,20,21];
  void checkSkills(int index){
    if(checkSkill[index]==true){
      checkSkill[index]=false;
    }else{
      checkSkill[index]=true;
    }
    emit(CheckSkillsState());
  }
  var picker = ImagePicker();
  File? image;
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(PickImageSuccessState());
    } else {
      print('No Image Selected');
      emit(PickImageErrorState(error: 'No Image Selected'));
    }
  }


  TextEditingController dateController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
    emit(SuccessChangeDateState());
  }


}
