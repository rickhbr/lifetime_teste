// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyQuoteModel _$CurrencyQuoteModelFromJson(Map<String, dynamic> json) =>
    CurrencyQuoteModel(
      cotacaoCompra: (json['cotacaoCompra'] as num).toDouble(),
      cotacaoVenda: (json['cotacaoVenda'] as num).toDouble(),
      dataHoraCotacao: json['dataHoraCotacao'] as String,
      tipoBoletim: json['tipoBoletim'] as String,
    );

Map<String, dynamic> _$CurrencyQuoteModelToJson(CurrencyQuoteModel instance) =>
    <String, dynamic>{
      'cotacaoCompra': instance.cotacaoCompra,
      'cotacaoVenda': instance.cotacaoVenda,
      'dataHoraCotacao': instance.dataHoraCotacao,
      'tipoBoletim': instance.tipoBoletim,
    };
