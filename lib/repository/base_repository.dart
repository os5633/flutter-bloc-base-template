import 'package:flutter_bloc_base_template/support/dio/dio_client.dart';

class BaseRepository {
  final DioClient dioClient = DioClient();
}

class NetworkFailure implements Exception {}

class ApiException implements Exception {
  const ApiException([
    this.code = '9999',
    this.message = 'API통신 에러입니다 관리자에게 문의 하세요',
  ]);

  factory ApiException.fromCode(String codeValue) {
    switch (codeValue) {
      case '1000':
        return ApiException(codeValue, '');
      case '1001':
        return ApiException(codeValue, '');
      default:
        return const ApiException();
    }
  }

  final String message;
  final String code;
}
