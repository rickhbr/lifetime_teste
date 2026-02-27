class ApiConstants {
  ApiConstants._();

  static const String baseUrl =
      'https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata';

  static const String currenciesPath = '/Moedas';

  static const String quotePath = '/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)';

  static const String formatParam = 'json';
}
