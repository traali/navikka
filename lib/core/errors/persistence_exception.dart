sealed class PersistenceException implements Exception {
  const PersistenceException(this.message, [this.originalError]);
  final String message;
  final dynamic originalError;

  @override
  String toString() => originalError != null
      ? 'PersistenceException: $message ($originalError)'
      : 'PersistenceException: $message';
}

class RecordNotFoundException extends PersistenceException {
  const RecordNotFoundException(String key) : super('Record not found: $key');
}

class CorruptedDataException extends PersistenceException {
  const CorruptedDataException(String key, dynamic error)
    : super('Data corrupted for key: $key', error);
}

class StoreVersionMismatchException extends PersistenceException {
  const StoreVersionMismatchException(this.storedVersion, this.currentVersion)
    : super(
        'Schema version mismatch. Stored: $storedVersion, Current: $currentVersion',
      );
  final int storedVersion;
  final int currentVersion;
}
