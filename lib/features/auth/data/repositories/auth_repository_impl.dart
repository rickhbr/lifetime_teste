import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Stream<bool> get authStateChanges => _datasource.authStateChanges;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _datasource.signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseError(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    await _datasource.signOut();
  }

  String _mapFirebaseError(String code) {
    return switch (code) {
      'user-not-found' => 'Usuário não encontrado.',
      'wrong-password' => 'Senha incorreta.',
      'invalid-email' => 'E-mail inválido.',
      'user-disabled' => 'Usuário desativado.',
      'invalid-credential' => 'Credenciais inválidas.',
      _ => 'Erro de autenticação. Tente novamente.',
    };
  }
}
