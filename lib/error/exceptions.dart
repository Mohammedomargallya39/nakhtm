class ServerException implements Exception {
  final String error;
  final int code;

  ServerException({
    required this.error,
    required this.code,
  });
}

class CacheException implements Exception {
  final dynamic error;

  CacheException(this.error);
}
