import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/features/auth/domain/domain.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInUseCase useCase;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    useCase = SignInUseCase(repository);
  });

  test('should call repository.signInWithEmailAndPassword with correct params',
      () async {
    when(() => repository.signInWithEmailAndPassword(any(), any()))
        .thenAnswer((_) async {});

    await useCase(const SignInParams(email: 'a@b.com', password: '123456'));

    verify(() => repository.signInWithEmailAndPassword('a@b.com', '123456'))
        .called(1);
  });
}
