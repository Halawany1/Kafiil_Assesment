class UserModel {
  int? status;
  bool? success;
  Data? data;
  String? accessToken;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
  }

}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? about;
  List<Tags>? tags;
  List<String>? favoriteSocialMedia;
  int? salary;
  String? email;
  String? birthDate;
  int? gender;
  Type? type;
  String? avatar;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    about = json['about'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add( Tags.fromJson(v));
      });
    }
    favoriteSocialMedia = json['favorite_social_media'].cast<String>();
    salary = json['salary'];
    email = json['email'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    type = json['type'] != null ?  Type.fromJson(json['type']) : null;
    avatar = json['avatar'];
  }

}

class Tags {
  int? id;
  String? name;


  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}

class Type {
  int? code;
  String? name;
  String? niceName;

  Type.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    niceName = json['nice_name'];
  }

}