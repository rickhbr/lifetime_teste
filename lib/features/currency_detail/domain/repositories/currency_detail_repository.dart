import '../entities/currency_quote_entity.dart';

abstract class CurrencyDetailRepository {
  Future<CurrencyQuoteEntity?> getLatestQuote(String currencyCode);
}
