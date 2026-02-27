import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/api_constants.dart';
import 'logging_interceptor.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(LoggingInterceptor loggingInterceptor) => Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          queryParameters: {'\$format': ApiConstants.formatParam},
        ),
      )..interceptors.add(loggingInterceptor);
}
