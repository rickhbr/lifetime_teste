// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) =>
    CurrencyModel(
      simbolo: json['simbolo'] as String,
      nomeFormatado: json['nomeFormatado'] as String,
      tipoMoeda: json['tipoMoeda'] as String,
    );

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'simbolo': instance.simbolo,
      'nomeFormatado': instance.nomeFormatado,
      'tipoMoeda': instance.tipoMoeda,
    };
