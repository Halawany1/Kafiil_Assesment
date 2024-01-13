part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}



class AuthenticationInitial extends AuthenticationState {}

class LoadingLoginState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {
  final UserModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginFailedState extends AuthenticationState {
  final String error;
  LoginFailedState({required this.error});
}

class LoadingSignUpState extends AuthenticationState {}

class SignUpSuccessState extends AuthenticationState {
}

class SignUpFailedState extends AuthenticationState {
  final String error;
  SignUpFailedState({required this.error});
}

class LoadingUserDataState extends AuthenticationState {}

class SuccessUserDataState extends AuthenticationState {}

class ErrorUserDataState extends AuthenticationState {
  final String error;
  ErrorUserDataState(this.error);
}

class ChangeValidateDataState extends AuthenticationState {}

class ChangeVisibalityState extends AuthenticationState {}

class ChangeCheckBoxState extends AuthenticationState {}

class ChangeRadioBoxState extends AuthenticationState {}

class ChangeCurrentRigesterScreenState extends AuthenticationState {}

class ChangeSalaryState extends AuthenticationState {}

class DeleteSkillState extends AuthenticationState {}

class CheckSkillsState extends AuthenticationState {}

class PickImageSuccessState extends AuthenticationState {

}

class PickImageErrorState extends AuthenticationState {
  final String error;

  PickImageErrorState({required this.error});
}
class SuccessChangeDateState extends AuthenticationState {}
