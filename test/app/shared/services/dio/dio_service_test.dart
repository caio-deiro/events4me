import 'package:events4me/app/shared/services/dio/dio_interceptor.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDioService extends Mock implements DioService {}

class MockCustomDioInterceptor extends Mock implements CustomDioInterceptor {}

void main() {
  test('', () {});
}
