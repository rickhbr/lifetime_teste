import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignInUseCase implements UseCase<void, SignInParams> {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  @override
  Future<void> call(SignInParams params) {
    return _repository.signInWithEmailAndPassword(params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});
}
