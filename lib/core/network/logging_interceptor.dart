import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      '──▶ ${options.method} ${options.uri}',
      name: 'HTTP',
    );
    if (options.queryParameters.isNotEmpty) {
      log(
        '    Query: ${options.queryParameters}',
        name: 'HTTP',
      );
    }
    if (options.data != null) {
      log(
        '    Body: ${options.data}',
        name: 'HTTP',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      '◀── ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.uri} '
      '(${response.data.toString().length} chars)',
      name: 'HTTP',
    );
    log(
      '    Response: ${_truncate(response.data.toString(), 500)}',
      name: 'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(
      '✖── ${err.response?.statusCode ?? 'NO STATUS'} '
      '${err.requestOptions.method} ${err.requestOptions.uri}',
      name: 'HTTP',
      error: err.message,
    );
    if (err.response?.data != null) {
      log(
        '    Error body: ${_truncate(err.response!.data.toString(), 300)}',
        name: 'HTTP',
      );
    }
    handler.next(err);
  }

  String _truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
