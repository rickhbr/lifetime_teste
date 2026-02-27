import '../../domain/domain.dart';

sealed class CurrenciesState {
  const CurrenciesState();
}

final class CurrenciesInitial extends CurrenciesState {
  const CurrenciesInitial();
}

final class CurrenciesLoading extends CurrenciesState {
  const CurrenciesLoading();
}

final class CurrenciesLoaded extends CurrenciesState {
  final List<CurrencyEntity> currencies;
  final List<CurrencyEntity> filteredCurrencies;
  final String searchQuery;

  const CurrenciesLoaded({
    required this.currencies,
    required this.filteredCurrencies,
    this.searchQuery = '',
  });
}

final class CurrenciesError extends CurrenciesState {
  final String message;
  const CurrenciesError(this.message);
}
