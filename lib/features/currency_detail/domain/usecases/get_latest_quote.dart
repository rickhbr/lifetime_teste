import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/currency_quote_entity.dart';
import '../repositories/currency_detail_repository.dart';

@lazySingleton
class GetLatestQuoteUseCase
    implements UseCase<CurrencyQuoteEntity?, String> {
  final CurrencyDetailRepository _repository;

  GetLatestQuoteUseCase(this._repository);

  @override
  Future<CurrencyQuoteEntity?> call(String currencyCode) {
    return _repository.getLatestQuote(currencyCode);
  }
}
