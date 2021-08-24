import 'package:dio/dio.dart';

abstract class ApiService{
  void init();

  Future<Response> getRequest(String url);
  Future<Response> postRequest(String url, dynamic data);
  Future<Response> putRequest(String url, dynamic data);
}