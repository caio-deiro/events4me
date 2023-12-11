import 'package:dio/dio.dart';

class ApiError extends DioException {
  final String apiErrorMessage;

  ApiError(DioException dioError, this.apiErrorMessage)
      : super(
            requestOptions: dioError.requestOptions,
            error: dioError.error,
            response: dioError.response,
            type: dioError.type);
}
