class CountriesModel {
  int? status;
  bool? success;
  List<Data>? data;
  Pagination? pagination;


  CountriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ?  Pagination.fromJson(json['pagination'])
        : null;
  }

}

class Data {
  int? id;
  String? countryCode;
  String? name;
  String? capital;

  Data({this.id, this.countryCode, this.name, this.capital});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['country_code'];
    name = json['name'];
    capital = json['capital'];
  }

}

class Pagination {
  int? count;
  int? total;
  int? perPage;
  int? currentPage;
  int? totalPages;
  Links? links;


  Pagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    total = json['total'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    links = json['links'] != null ?  Links.fromJson(json['links']) : null;
  }


}

class Links {
  String? next;


  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
  }

}