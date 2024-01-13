class ErrorsModel {
  String? message;
  Errors? errors;

  ErrorsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors =
    json['errors'] != null ?  Errors.fromJson(json['errors']) : null;
  }

}

class Errors {
  List<String>? email;
  List<String>? password;

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    password = json['password'].cast<String>();
  }

}