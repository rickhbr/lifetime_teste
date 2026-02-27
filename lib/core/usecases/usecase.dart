abstract class UseCase<Output, Params> {
  Future<Output> call(Params params);
}

abstract class StreamUseCase<Output, Params> {
  Stream<Output> call(Params params);
}

class NoParams {
  const NoParams();
}
