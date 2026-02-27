sealed class Failure {
  final String message;
  const Failure(this.message);
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erro no servidor. Tente novamente.']);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sem conexão com a internet.']);
}

final class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Erro de autenticação.']);
}

final class NoDataFailure extends Failure {
  const NoDataFailure([super.message = 'Nenhum dado disponível.']);
}
