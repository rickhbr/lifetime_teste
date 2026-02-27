import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/currency_entity.dart';

part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel {
  final String simbolo;
  final String nomeFormatado;
  final String tipoMoeda;

  const CurrencyModel({
    required this.simbolo,
    required this.nomeFormatado,
    required this.tipoMoeda,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);

  CurrencyEntity toEntity() => CurrencyEntity(
        symbol: simbolo,
        name: nomeFormatado,
        type: tipoMoeda,
      );
}
