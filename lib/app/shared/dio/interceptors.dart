import 'package:dio/dio.dart';
import 'package:enhance/app/shared/services/storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RequestHeadersInterceptors extends Interceptor {
  final Dio _dio;

  RequestHeadersInterceptors(Dio dio) : _dio = dio;

  static const isRetryRequest = 'isRetry';

  @override
  Future onRequest(RequestOptions options) async {
    final user = await SharedPreferencesHelper.getUser();
    final token = user?.jwtToken;
    if (token != null)
      options.headers.addAll({'Authorization': 'Bearer $token'});
  }

  @override
  Future onError(DioError dioError) async {
    final statusCode = dioError?.response?.statusCode;
    final extra = dioError?.request?.extra;
    if (extra != null &&
        extra[isRetryRequest] == true &&
        (statusCode == 401 || statusCode == 403)) {
      return super.onError(dioError);
    } else if (statusCode == 401 || statusCode == 403) {
      // return _authenticateAndRetry(dioError);
    } else {
      return super.onError(dioError);
    }
  }
}
