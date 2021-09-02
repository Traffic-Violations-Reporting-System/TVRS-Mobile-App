

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "http://3.139.55.67:4000/api/v1/mobile";

class ApiServiceImpl implements ApiService{

  late Dio _dio;

  @override
  void init() async {
    final String myAuthToken = await _getMyAuthToken();
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {
        "Authorization" : "$myAuthToken",
      },
    ));

    //initializeInterceptors();
  }


  @override
  Future<Response?> getRequest(String url, Function errorHandler, {var options}) async{
    Response? response;
    try {
      response = await _dio.get(url, options: options);
    } on DioError catch (e) {
      print(e.message);
      errorHandler(e);
    }

    return response;
  }

  @override
  Future<Response?> postRequest(String url, dynamic data, Function errorHandler, {var options}) async{
    Response? response;
    try {
      response = await _dio.post(url, data: data, options: options);
    } on DioError catch (e) {
      print(e.message);
      errorHandler(e);
    }

    return response;
  }

  @override
  Future<Response?> putRequest(String url, dynamic data, Function errorHandler, {var options}) async{
    Response? response;
    try {
      response = await _dio.put(url, data: data, options: options);
    } on DioError catch (e) {
      print(e.message);
      errorHandler(e);
    }

    return response;
  }

  initializeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError error, handler){
          print(error.message);
        },
        onRequest: (request, handler){
          print("${request.method} | ${request.path}");
        },
        onResponse: (response, handler){
          print("${response.statusCode} ${response.statusMessage} ${response.data}");
        }
    ));
  }

  _getMyAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('AuthToken') ?? "";
  }

}