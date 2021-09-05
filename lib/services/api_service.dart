import 'package:dio/dio.dart';

abstract class ApiService{
  void init();

  Future<Response?> getRequest(String url, Function errorHandler,{var options});
  Future<Response?> postRequest(String url, dynamic data, Function errorHandler,{var options});
  Future<Response?> putRequest(String url, dynamic data, Function errorHandler,{var options});
}