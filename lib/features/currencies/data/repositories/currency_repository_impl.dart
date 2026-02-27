import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../datasources/currency_remote_datasource.dart';

@LazySingleton(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDatasource _datasource;

  CurrencyRepositoryImpl(this._datasource);

  @override
  Future<List<CurrencyEntity>> getCurrencies() async {
    try {
      final models = await _datasource.getCurrencies();
      return models.map((m) => m.toEntity()).toList();
    } on ServerException {
      throw const ServerFailure();
    }
  }
}
