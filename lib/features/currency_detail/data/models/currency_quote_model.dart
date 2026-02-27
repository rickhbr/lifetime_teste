import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/currency_quote_entity.dart';

part 'currency_quote_model.g.dart';

@JsonSerializable()
class CurrencyQuoteModel {
  final double cotacaoCompra;
  final double cotacaoVenda;
  final String dataHoraCotacao;
  final String tipoBoletim;

  const CurrencyQuoteModel({
    required this.cotacaoCompra,
    required this.cotacaoVenda,
    required this.dataHoraCotacao,
    required this.tipoBoletim,
  });

  factory CurrencyQuoteModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyQuoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyQuoteModelToJson(this);

  CurrencyQuoteEntity toEntity() => CurrencyQuoteEntity(
        buyRate: cotacaoCompra,
        sellRate: cotacaoVenda,
        quoteDateTime: DateTime.parse(dataHoraCotacao),
        bulletinType: tipoBoletim,
      );
}
