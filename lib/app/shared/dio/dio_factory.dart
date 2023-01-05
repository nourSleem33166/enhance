import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:enhance/app/shared/dio/interceptors.dart';

class DioFactory {
  static const baseURL = 'https://enhance-app.herokuapp.com';
  static const apiBaseURL = '$baseURL/';

  static Dio create() {
    final baseOptions = BaseOptions(baseUrl: apiBaseURL);
    // baseOptions.headers[Headers.contentEncodingHeader] = 'gzip';
    final dio = Dio(baseOptions);
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(RequestHeadersInterceptors(dio));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
