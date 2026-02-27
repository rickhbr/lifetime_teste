import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetAuthStateUseCase implements StreamUseCase<bool, NoParams> {
  final AuthRepository _repository;

  GetAuthStateUseCase(this._repository);

  @override
  Stream<bool> call(NoParams params) {
    return _repository.authStateChanges;
  }
}
