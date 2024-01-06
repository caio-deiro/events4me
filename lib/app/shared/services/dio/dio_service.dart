import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:events4me/app/shared/services/dio/dio_interceptor.dart';

class DioService extends DioForNative {
  static const baseUrl = '';

  DioService()
      : super(BaseOptions(
          baseUrl: baseUrl,
          contentType: 'application/json',
        )) {
    super.interceptors.add(CustomDioInterceptor(this));
  }
}
