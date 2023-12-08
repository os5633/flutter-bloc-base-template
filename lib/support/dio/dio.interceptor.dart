import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomInterceptors extends Interceptor {
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  Map<String, String> platformHeader = <String, String>{};

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('REQUEST[${options.method}] => ${options.method}: ${options.path}');

    final idToken = await fireAuth.currentUser?.getIdToken();
    log("$idToken", name: "AUTHORIZATION ID TOKEN");
    if (idToken != null) {
      options.headers.addAll({
        "Authorization": "Bearer $idToken",
      });
    }
    options.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
    });

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => ${response.requestOptions.method}: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    log('ERROR :: error.response?.data :: ${err.type} ');
    return super.onError(err, handler);
  }
}
