import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/core/core.dart';
import 'package:ptax_app/features/currencies/domain/domain.dart';
import 'package:ptax_app/features/currencies/presentation/cubit/currencies_cubit.dart';
import 'package:ptax_app/features/currencies/presentation/cubit/currencies_state.dart';

class MockGetCurrenciesUseCase extends Mock implements GetCurrenciesUseCase {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockGetCurrenciesUseCase getCurrencies;

  final tCurrencies = [
    const CurrencyEntity(symbol: 'USD', name: 'Dólar Americano', type: 'A'),
    const CurrencyEntity(symbol: 'EUR', name: 'Euro', type: 'A'),
    const CurrencyEntity(symbol: 'GBP', name: 'Libra Esterlina', type: 'A'),
  ];

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    getCurrencies = MockGetCurrenciesUseCase();
  });

  CurrenciesCubit buildCubit() => CurrenciesCubit(getCurrencies);

  group('CurrenciesCubit', () {
    blocTest<CurrenciesCubit, CurrenciesState>(
      'emits [CurrenciesLoading, CurrenciesLoaded] on loadCurrencies success',
      build: buildCubit,
      setUp: () {
        when(() => getCurrencies(any()))
            .thenAnswer((_) async => tCurrencies);
      },
      act: (cubit) => cubit.loadCurrencies(),
      expect: () => [
        isA<CurrenciesLoading>(),
        isA<CurrenciesLoaded>()
            .having((s) => s.currencies, 'currencies', tCurrencies)
            .having(
                (s) => s.filteredCurrencies, 'filteredCurrencies', tCurrencies),
      ],
    );

    blocTest<CurrenciesCubit, CurrenciesState>(
      'emits [CurrenciesLoading, CurrenciesError] on Failure',
      build: buildCubit,
      setUp: () {
        when(() => getCurrencies(any()))
            .thenThrow(const ServerFailure('Erro no servidor'));
      },
      act: (cubit) => cubit.loadCurrencies(),
      expect: () => [
        isA<CurrenciesLoading>(),
        isA<CurrenciesError>()
            .having((e) => e.message, 'message', 'Erro no servidor'),
      ],
    );

    blocTest<CurrenciesCubit, CurrenciesState>(
      'emits [CurrenciesLoading, CurrenciesError] on generic exception',
      build: buildCubit,
      setUp: () {
        when(() => getCurrencies(any())).thenThrow(Exception('unexpected'));
      },
      act: (cubit) => cubit.loadCurrencies(),
      expect: () => [
        isA<CurrenciesLoading>(),
        isA<CurrenciesError>().having(
          (e) => e.message,
          'message',
          'Erro inesperado ao carregar moedas.',
        ),
      ],
    );

    blocTest<CurrenciesCubit, CurrenciesState>(
      'filterCurrencies("USD") emits CurrenciesLoaded with filtered list',
      build: buildCubit,
      seed: () => CurrenciesLoaded(
        currencies: tCurrencies,
        filteredCurrencies: tCurrencies,
      ),
      act: (cubit) => cubit.filterCurrencies('USD'),
      expect: () => [
        isA<CurrenciesLoaded>()
            .having((s) => s.filteredCurrencies.length, 'length', 1)
            .having((s) => s.filteredCurrencies.first.symbol, 'symbol', 'USD')
            .having((s) => s.searchQuery, 'searchQuery', 'USD'),
      ],
    );

    blocTest<CurrenciesCubit, CurrenciesState>(
      'filterCurrencies("") emits CurrenciesLoaded with full list',
      build: buildCubit,
      seed: () => CurrenciesLoaded(
        currencies: tCurrencies,
        filteredCurrencies: [tCurrencies.first],
        searchQuery: 'USD',
      ),
      act: (cubit) => cubit.filterCurrencies(''),
      expect: () => [
        isA<CurrenciesLoaded>()
            .having(
                (s) => s.filteredCurrencies.length, 'length', tCurrencies.length)
            .having((s) => s.searchQuery, 'searchQuery', ''),
      ],
    );
  });
}
