class ServerException implements Exception {
  final String? message;
  const ServerException([this.message]);
}

class NoDataException implements Exception {
  final String? message;
  const NoDataException([this.message]);
}
