part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class ChangeNavBarState extends LayoutState {}

class LoadingUserDataState extends LayoutState {}

class SuccessUserDataState extends LayoutState {}

class ErrorUserDataState extends LayoutState {
  final String error;

  ErrorUserDataState(this.error);
}


class LoadingServicesDataState extends LayoutState {}

class SuccessServicesDataState extends LayoutState {}

class ErrorServicesDataState extends LayoutState {
  final String error;

  ErrorServicesDataState(this.error);
}

class LoadingServicesPopularDataState extends LayoutState {}

class SuccessServicesPopularDataState extends LayoutState {}

class ErrorServicesPopularDataState extends LayoutState {
  final String error;

  ErrorServicesPopularDataState(this.error);
}


class LoadingCountriesDataState extends LayoutState {}

class SuccessCountriesDataState extends LayoutState {}

class ErrorCountriesDataState extends LayoutState {
  final String error;

  ErrorCountriesDataState(this.error);
}


