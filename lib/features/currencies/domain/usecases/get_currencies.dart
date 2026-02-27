import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/currency_entity.dart';
import '../repositories/currency_repository.dart';

@lazySingleton
class GetCurrenciesUseCase
    implements UseCase<List<CurrencyEntity>, NoParams> {
  final CurrencyRepository _repository;

  GetCurrenciesUseCase(this._repository);

  @override
  Future<List<CurrencyEntity>> call(NoParams params) {
    return _repository.getCurrencies();
  }
}
