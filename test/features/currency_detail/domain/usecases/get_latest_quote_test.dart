import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/features/currency_detail/domain/domain.dart';

class MockCurrencyDetailRepository extends Mock
    implements CurrencyDetailRepository {}

void main() {
  late GetLatestQuoteUseCase useCase;
  late MockCurrencyDetailRepository repository;

  setUp(() {
    repository = MockCurrencyDetailRepository();
    useCase = GetLatestQuoteUseCase(repository);
  });

  test('should return latest quote from repository', () async {
    final quote = CurrencyQuoteEntity(
      buyRate: 5.25,
      sellRate: 5.30,
      quoteDateTime: DateTime(2024, 1, 15),
      bulletinType: 'Fechamento',
    );
    when(() => repository.getLatestQuote(any())).thenAnswer((_) async => quote);

    final result = await useCase('USD');

    expect(result, quote);
    verify(() => repository.getLatestQuote('USD')).called(1);
  });
}
