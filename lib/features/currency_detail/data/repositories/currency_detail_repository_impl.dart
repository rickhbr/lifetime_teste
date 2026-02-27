import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../datasources/currency_detail_remote_datasource.dart';

@LazySingleton(as: CurrencyDetailRepository)
class CurrencyDetailRepositoryImpl implements CurrencyDetailRepository {
  final CurrencyDetailRemoteDatasource _datasource;

  CurrencyDetailRepositoryImpl(this._datasource);

  @override
  Future<CurrencyQuoteEntity?> getLatestQuote(String currencyCode) async {
    try {
      final model = await _datasource.getLatestQuote(currencyCode);
      return model?.toEntity();
    } on ServerException {
      throw const ServerFailure();
    }
  }
}
