import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/core/core.dart';
import 'package:ptax_app/features/auth/domain/domain.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetAuthStateUseCase useCase;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    useCase = GetAuthStateUseCase(repository);
  });

  test('should return repository.authStateChanges stream', () {
    final stream = Stream<bool>.fromIterable([true, false]);
    when(() => repository.authStateChanges).thenAnswer((_) => stream);

    final result = useCase(const NoParams());

    expect(result, emitsInOrder([true, false]));
    verify(() => repository.authStateChanges).called(1);
  });
}
