import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/core/core.dart';
import 'package:ptax_app/features/currencies/domain/domain.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late GetCurrenciesUseCase useCase;
  late MockCurrencyRepository repository;

  setUp(() {
    repository = MockCurrencyRepository();
    useCase = GetCurrenciesUseCase(repository);
  });

  test('should return list of currencies from repository', () async {
    final currencies = [
      const CurrencyEntity(symbol: 'USD', name: 'Dólar Americano', type: 'A'),
      const CurrencyEntity(symbol: 'EUR', name: 'Euro', type: 'A'),
    ];
    when(() => repository.getCurrencies()).thenAnswer((_) async => currencies);

    final result = await useCase(const NoParams());

    expect(result, currencies);
    verify(() => repository.getCurrencies()).called(1);
  });
}
