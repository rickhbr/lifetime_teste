import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/core/core.dart';
import 'package:ptax_app/features/currency_detail/domain/domain.dart';
import 'package:ptax_app/features/currency_detail/presentation/cubit/currency_detail_cubit.dart';
import 'package:ptax_app/features/currency_detail/presentation/cubit/currency_detail_state.dart';

class MockGetLatestQuoteUseCase extends Mock implements GetLatestQuoteUseCase {}

void main() {
  late MockGetLatestQuoteUseCase getLatestQuote;

  final tQuote = CurrencyQuoteEntity(
    buyRate: 5.25,
    sellRate: 5.30,
    quoteDateTime: DateTime(2024, 1, 15),
    bulletinType: 'Fechamento',
  );

  setUp(() {
    getLatestQuote = MockGetLatestQuoteUseCase();
  });

  CurrencyDetailCubit buildCubit() => CurrencyDetailCubit(getLatestQuote);

  group('CurrencyDetailCubit', () {
    blocTest<CurrencyDetailCubit, CurrencyDetailState>(
      'emits [CurrencyDetailLoading, CurrencyDetailLoaded] on success',
      build: buildCubit,
      setUp: () {
        when(() => getLatestQuote(any())).thenAnswer((_) async => tQuote);
      },
      act: (cubit) => cubit.loadQuote('USD', 'Dólar Americano'),
      expect: () => [
        isA<CurrencyDetailLoading>(),
        isA<CurrencyDetailLoaded>()
            .having((s) => s.quote, 'quote', tQuote)
            .having((s) => s.currencyName, 'currencyName', 'Dólar Americano'),
      ],
    );

    blocTest<CurrencyDetailCubit, CurrencyDetailState>(
      'emits [CurrencyDetailLoading, CurrencyDetailNoData] when quote is null',
      build: buildCubit,
      setUp: () {
        when(() => getLatestQuote(any())).thenAnswer((_) async => null);
      },
      act: (cubit) => cubit.loadQuote('XYZ', 'Moeda Teste'),
      expect: () => [
        isA<CurrencyDetailLoading>(),
        isA<CurrencyDetailNoData>()
            .having((s) => s.currencyName, 'currencyName', 'Moeda Teste'),
      ],
    );

    blocTest<CurrencyDetailCubit, CurrencyDetailState>(
      'emits [CurrencyDetailLoading, CurrencyDetailError] on Failure',
      build: buildCubit,
      setUp: () {
        when(() => getLatestQuote(any()))
            .thenThrow(const ServerFailure('Erro no servidor'));
      },
      act: (cubit) => cubit.loadQuote('USD', 'Dólar Americano'),
      expect: () => [
        isA<CurrencyDetailLoading>(),
        isA<CurrencyDetailError>()
            .having((e) => e.message, 'message', 'Erro no servidor'),
      ],
    );

    blocTest<CurrencyDetailCubit, CurrencyDetailState>(
      'emits [CurrencyDetailLoading, CurrencyDetailError] on generic exception',
      build: buildCubit,
      setUp: () {
        when(() => getLatestQuote(any())).thenThrow(Exception('unexpected'));
      },
      act: (cubit) => cubit.loadQuote('USD', 'Dólar Americano'),
      expect: () => [
        isA<CurrencyDetailLoading>(),
        isA<CurrencyDetailError>().having(
          (e) => e.message,
          'message',
          'Erro inesperado ao carregar cotação.',
        ),
      ],
    );
  });
}
