abstract class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

/// Network unavailable (offline, timeout, DNS failure)
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network unavailable']);
}

/// Failed to parse data (XML, JSON, malformed response)
class ParsingFailure extends Failure {
  const ParsingFailure([super.message = 'Failed to parse data']);
}

/// Business rule validation failed
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Database/Drift related errors
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
