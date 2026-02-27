import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'currencies_state.dart';

@injectable
class CurrenciesCubit extends Cubit<CurrenciesState> {
  final GetCurrenciesUseCase _getCurrencies;

  CurrenciesCubit(this._getCurrencies) : super(const CurrenciesInitial());

  Future<void> loadCurrencies() async {
    emit(const CurrenciesLoading());
    try {
      final currencies = await _getCurrencies(const NoParams());
      emit(CurrenciesLoaded(
        currencies: currencies,
        filteredCurrencies: currencies,
      ));
    } on Failure catch (e) {
      emit(CurrenciesError(e.message));
    } catch (_) {
      emit(const CurrenciesError('Erro inesperado ao carregar moedas.'));
    }
  }

  void filterCurrencies(String query) {
    final currentState = state;
    if (currentState is! CurrenciesLoaded) return;

    final lowerQuery = query.toLowerCase();
    final filtered = currentState.currencies.where((c) {
      return c.symbol.toLowerCase().contains(lowerQuery) ||
          c.name.toLowerCase().contains(lowerQuery);
    }).toList();

    emit(CurrenciesLoaded(
      currencies: currentState.currencies,
      filteredCurrencies: filtered,
      searchQuery: query,
    ));
  }
}
