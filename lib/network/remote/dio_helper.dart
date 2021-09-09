import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
 static Dio dio;


  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  Future<Response> getData({
  @required String url,
    @required Map query,
})async
  {
    return await dio.get(url, queryParameters: query);
  }
}