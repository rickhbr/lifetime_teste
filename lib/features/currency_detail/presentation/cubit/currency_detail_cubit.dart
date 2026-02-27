import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'currency_detail_state.dart';

@injectable
class CurrencyDetailCubit extends Cubit<CurrencyDetailState> {
  final GetLatestQuoteUseCase _getLatestQuote;

  CurrencyDetailCubit(this._getLatestQuote)
      : super(const CurrencyDetailLoading());

  Future<void> loadQuote(String code, String name) async {
    emit(const CurrencyDetailLoading());
    try {
      final quote = await _getLatestQuote(code);
      if (quote == null) {
        emit(CurrencyDetailNoData(currencyName: name));
      } else {
        emit(CurrencyDetailLoaded(quote: quote, currencyName: name));
      }
    } on Failure catch (e) {
      emit(CurrencyDetailError(e.message));
    } catch (_) {
      emit(const CurrencyDetailError('Erro inesperado ao carregar cotação.'));
    }
  }
}
