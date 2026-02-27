import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../models/currency_model.dart';

abstract class CurrencyRemoteDatasource {
  Future<List<CurrencyModel>> getCurrencies();
}

@LazySingleton(as: CurrencyRemoteDatasource)
class CurrencyRemoteDatasourceImpl implements CurrencyRemoteDatasource {
  final Dio _dio;

  CurrencyRemoteDatasourceImpl(this._dio);

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    try {
      final response = await _dio.get(ApiConstants.currenciesPath);
      final data = response.data as Map<String, dynamic>;
      final list = data['value'] as List;
      return list
          .map((e) => CurrencyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException {
      throw const ServerException('Erro ao buscar moedas');
    }
  }
}
