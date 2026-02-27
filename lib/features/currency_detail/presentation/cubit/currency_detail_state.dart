import '../../domain/domain.dart';

sealed class CurrencyDetailState {
  const CurrencyDetailState();
}

final class CurrencyDetailLoading extends CurrencyDetailState {
  const CurrencyDetailLoading();
}

final class CurrencyDetailLoaded extends CurrencyDetailState {
  final CurrencyQuoteEntity quote;
  final String currencyName;
  const CurrencyDetailLoaded({required this.quote, required this.currencyName});
}

final class CurrencyDetailNoData extends CurrencyDetailState {
  final String currencyName;
  const CurrencyDetailNoData({required this.currencyName});
}

final class CurrencyDetailError extends CurrencyDetailState {
  final String message;
  const CurrencyDetailError(this.message);
}
