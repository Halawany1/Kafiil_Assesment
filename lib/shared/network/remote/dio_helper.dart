
import 'package:dio/dio.dart';

class DioHelper{
  static Dio ?dio;
  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: "https://test.kafiil.com/api/test/",
          receiveDataWhenStatusError: true,
        )
    );
  }
  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      "Accept-Language":lang,
      if (token != null) 'Authorization': token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required url,
    required Map<String,dynamic> data,
    String lang="en",
    String ?token
  }) async{
    dio!.options.headers = {
      "Accept": "application/json",
      "Accept-Language":lang,
      if (token != null) 'Authorization': token,
    };
    return await dio!.post(url,data: data);
  }

  static Future<Response> putData({
    required url,
    required Map<String,dynamic> data,
    String lang='en',
    String ?token
  }) async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      if (token != null) 'Authorization': token,
    };
    return await dio!.put(url,data: data);
  }
}