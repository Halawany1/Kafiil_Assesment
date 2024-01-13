class ServicesModel {
  int? status;
  bool? success;
  List<DataServices>? data;

  ServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <DataServices>[];
      json['data'].forEach((v) {
        data!.add( DataServices.fromJson(v));
      });
    }
  }

}

class DataServices {
  int? id;
  String? mainImage;
  int? price;
  int? priceAfterDiscount;
  String? title;
  int? averageRating;
  int? completedSalesCount;
  bool? recommended;


  DataServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainImage = json['main_image'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    title = json['title'];
    averageRating = json['average_rating'];
    completedSalesCount = json['completed_sales_count'];
    recommended = json['recommended'];
  }

}