

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/services/api_service.dart';

const BASE_URL = "http://3.142.238.131:4000/api/v1/mobile";
const API_KEY = "fb12a31181aa4498ba52877978913275";

class ApiServiceImpl implements ApiService{

  late Dio _dio;

  @override
  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      //headers: {"Authorization" : "$API_KEY"}
    ));

    //initializeInterceptors();
  }


  @override
  Future<Response> getRequest(String url) async{
    Response response;
    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  @override
  Future<Response> postRequest(String url, dynamic data) async{
    Response response;
    try {
      response = await _dio.post(url, data: data);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  @override
  Future<Response> putRequest(String url, dynamic data) async{
    Response response;
    try {
      response = await _dio.put(url, data: data);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
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

}