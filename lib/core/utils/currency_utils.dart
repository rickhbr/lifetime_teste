/// Utility class for currency display helpers.
///
/// Maps BCB PTAX currency codes to country flag emojis and currency symbols.
/// Uses Unicode regional indicator symbols — no external packages needed.
class CurrencyUtils {
  CurrencyUtils._();

  /// Converts a 2-letter country code to a flag emoji.
  ///
  /// Example: 'US' → '🇺🇸', 'BR' → '🇧🇷'
  static String countryCodeToFlag(String countryCode) {
    final upper = countryCode.toUpperCase();
    if (upper.length != 2) return '';
    final first = upper.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final second = upper.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(first) + String.fromCharCode(second);
  }

  /// Maps a BCB currency code (e.g. 'USD') to a flag emoji.
  static String flagForCurrency(String currencyCode) {
    final code = currencyCode.toUpperCase().trim();
    final country = _currencyToCountry[code];
    if (country == null) {
      if (code.length >= 2) {
        return countryCodeToFlag(code.substring(0, 2));
      }
      return '💱';
    }
    return countryCodeToFlag(country);
  }

  /// Maps a BCB currency code to its symbol (e.g. 'USD' → '\$').
  static String symbolForCurrency(String currencyCode) {
    return _currencyToSymbol[currencyCode.toUpperCase().trim()] ?? currencyCode;
  }

  /// Currency code → ISO 3166-1 alpha-2 country code.
  static const _currencyToCountry = <String, String>{
    'USD': 'US',
    'EUR': 'EU',
    'GBP': 'GB',
    'JPY': 'JP',
    'CHF': 'CH',
    'AUD': 'AU',
    'CAD': 'CA',
    'CNY': 'CN',
    'HKD': 'HK',
    'NZD': 'NZ',
    'SEK': 'SE',
    'SGD': 'SG',
    'NOK': 'NO',
    'MXN': 'MX',
    'KRW': 'KR',
    'TRY': 'TR',
    'INR': 'IN',
    'RUB': 'RU',
    'ZAR': 'ZA',
    'BRL': 'BR',
    'ARS': 'AR',
    'CLP': 'CL',
    'COP': 'CO',
    'PEN': 'PE',
    'UYU': 'UY',
    'PYG': 'PY',
    'BOB': 'BO',
    'VEF': 'VE',
    'DKK': 'DK',
    'PLN': 'PL',
    'CZK': 'CZ',
    'HUF': 'HU',
    'RON': 'RO',
    'ISK': 'IS',
    'PHP': 'PH',
    'THB': 'TH',
    'MYR': 'MY',
    'IDR': 'ID',
    'ILS': 'IL',
    'SAR': 'SA',
    'AED': 'AE',
    'KWD': 'KW',
    'EGP': 'EG',
    'NGN': 'NG',
    'TWD': 'TW',
    'VND': 'VN',
    'PKR': 'PK',
    'BDT': 'BD',
    'QAR': 'QA',
    'OMR': 'OM',
    'BHD': 'BH',
    'JOD': 'JO',
    'LBP': 'LB',
    'MAD': 'MA',
    'TND': 'TN',
    'GHS': 'GH',
    'KES': 'KE',
    'ETB': 'ET',
    'BGN': 'BG',
    'HRK': 'HR',
    'UAH': 'UA',
    'GEL': 'GE',
    'AMD': 'AM',
    'AZN': 'AZ',
    'KZT': 'KZ',
    'UZS': 'UZ',
  };

  /// Currency code → symbol.
  static const _currencyToSymbol = <String, String>{
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'CHF': 'Fr',
    'AUD': 'A\$',
    'CAD': 'C\$',
    'CNY': '¥',
    'HKD': 'HK\$',
    'NZD': 'NZ\$',
    'SEK': 'kr',
    'SGD': 'S\$',
    'NOK': 'kr',
    'MXN': 'Mex\$',
    'KRW': '₩',
    'TRY': '₺',
    'INR': '₹',
    'RUB': '₽',
    'ZAR': 'R',
    'BRL': 'R\$',
    'ARS': 'AR\$',
    'CLP': 'CL\$',
    'COP': 'CO\$',
    'PEN': 'S/',
    'UYU': 'UY\$',
    'PYG': '₲',
    'BOB': 'Bs',
    'DKK': 'kr',
    'PLN': 'zł',
    'CZK': 'Kč',
    'HUF': 'Ft',
    'RON': 'lei',
    'ISK': 'kr',
    'PHP': '₱',
    'THB': '฿',
    'MYR': 'RM',
    'IDR': 'Rp',
    'ILS': '₪',
    'SAR': '﷼',
    'AED': 'د.إ',
    'KWD': 'د.ك',
    'EGP': 'E£',
    'TWD': 'NT\$',
    'VND': '₫',
    'PKR': '₨',
  };
}
