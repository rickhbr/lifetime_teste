import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../models/currency_quote_model.dart';

abstract class CurrencyDetailRemoteDatasource {
  Future<CurrencyQuoteModel?> getLatestQuote(String currencyCode);
}

@LazySingleton(as: CurrencyDetailRemoteDatasource)
class CurrencyDetailRemoteDatasourceImpl
    implements CurrencyDetailRemoteDatasource {
  final Dio _dio;

  CurrencyDetailRemoteDatasourceImpl(this._dio);

  @override
  Future<CurrencyQuoteModel?> getLatestQuote(String currencyCode) async {
    try {
      final dateStr = DateFormat('MM-dd-yyyy').format(DateTime.now());
      final response = await _dio.get(
        ApiConstants.quotePath,
        queryParameters: {
          '@moeda': "'$currencyCode'",
          '@dataCotacao': "'$dateStr'",
        },
      );
      final data = response.data as Map<String, dynamic>;
      final list = data['value'] as List;
      if (list.isEmpty) return null;
      return CurrencyQuoteModel.fromJson(list.last as Map<String, dynamic>);
    } on DioException {
      throw const ServerException('Erro ao buscar cotação');
    }
  }
}
