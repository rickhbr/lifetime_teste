import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/core/core.dart';
import 'package:ptax_app/features/auth/domain/domain.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOutUseCase useCase;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    useCase = SignOutUseCase(repository);
  });

  test('should call repository.signOut', () async {
    when(() => repository.signOut()).thenAnswer((_) async {});

    await useCase(const NoParams());

    verify(() => repository.signOut()).called(1);
  });
}
