import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signIn;
  final SignOutUseCase _signOut;
  final GetAuthStateUseCase _getAuthState;
  late final StreamSubscription<bool> _authSubscription;

  AuthCubit(this._signIn, this._signOut, this._getAuthState)
      : super(const AuthInitial()) {
    _authSubscription =
        _getAuthState(const NoParams()).listen((isAuthenticated) {
      if (isAuthenticated) {
        emit(const Authenticated());
      } else {
        emit(const Unauthenticated());
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    emit(const AuthLoading());
    try {
      await _signIn(SignInParams(email: email, password: password));
    } on AuthFailure catch (e) {
      emit(AuthError(e.message));
    } catch (_) {
      emit(const AuthError('Erro inesperado. Tente novamente.'));
    }
  }

  Future<void> signOut() async {
    await _signOut(const NoParams());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
