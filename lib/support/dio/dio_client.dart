import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_base_template/common/common.dart';
import 'dio.interceptor.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  final Dio client = Dio();
  final String baseUrl = environment['baseUrl']!;
  final List<Interceptor>? interceptors;

  DioClient({this.interceptors}) {
    client
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter;
    if (interceptors?.isNotEmpty ?? false) {
      client.interceptors.addAll(interceptors!);
    }

    client.interceptors.add(CustomInterceptors());
    if (kDebugMode) {
      client.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }
  }
}
