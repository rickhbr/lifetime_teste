class CurrencyQuoteEntity {
  final double buyRate;
  final double sellRate;
  final DateTime quoteDateTime;
  final String bulletinType;

  const CurrencyQuoteEntity({
    required this.buyRate,
    required this.sellRate,
    required this.quoteDateTime,
    required this.bulletinType,
  });
}
