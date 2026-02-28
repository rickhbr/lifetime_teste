import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptax_app/core/core.dart';
import 'package:ptax_app/features/auth/domain/domain.dart';
import 'package:ptax_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ptax_app/features/auth/presentation/cubit/auth_state.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockGetAuthStateUseCase extends Mock implements GetAuthStateUseCase {}

class FakeSignInParams extends Fake implements SignInParams {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockSignInUseCase signIn;
  late MockSignOutUseCase signOut;
  late MockGetAuthStateUseCase getAuthState;
  late StreamController<bool> authStreamController;

  setUpAll(() {
    registerFallbackValue(FakeSignInParams());
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    signIn = MockSignInUseCase();
    signOut = MockSignOutUseCase();
    getAuthState = MockGetAuthStateUseCase();
    authStreamController = StreamController<bool>();

    when(() => getAuthState(any()))
        .thenAnswer((_) => authStreamController.stream);
  });

  tearDown(() {
    authStreamController.close();
  });

  AuthCubit buildCubit() => AuthCubit(signIn, signOut, getAuthState);

  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits [Authenticated] when auth stream emits true',
      build: buildCubit,
      act: (cubit) => authStreamController.add(true),
      expect: () => [isA<Authenticated>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Unauthenticated] when auth stream emits false',
      build: buildCubit,
      act: (cubit) => authStreamController.add(false),
      expect: () => [isA<Unauthenticated>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading] on signIn success',
      build: buildCubit,
      setUp: () {
        when(() => signIn(any())).thenAnswer((_) async {});
      },
      act: (cubit) => cubit.signIn('a@b.com', '123456'),
      expect: () => [isA<AuthLoading>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] on signIn with AuthFailure',
      build: buildCubit,
      setUp: () {
        when(() => signIn(any()))
            .thenThrow(const AuthFailure('Credenciais inválidas'));
      },
      act: (cubit) => cubit.signIn('a@b.com', 'wrong'),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>()
            .having((e) => e.message, 'message', 'Credenciais inválidas'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] on signIn with generic exception',
      build: buildCubit,
      setUp: () {
        when(() => signIn(any())).thenThrow(Exception('unexpected'));
      },
      act: (cubit) => cubit.signIn('a@b.com', '123456'),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (e) => e.message,
          'message',
          'Erro inesperado. Tente novamente.',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'calls signOut use case',
      build: buildCubit,
      setUp: () {
        when(() => signOut(any())).thenAnswer((_) async {});
      },
      act: (cubit) => cubit.signOut(),
      verify: (_) {
        verify(() => signOut(any())).called(1);
      },
    );
  });
}
