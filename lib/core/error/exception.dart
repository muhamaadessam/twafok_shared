import 'error_model.dart';

class ServerException implements Exception {
  const ServerException({
    required this.errorMessageModel,
  });

  final ErrorMessageModel errorMessageModel;
}

class LocalDatabaseException implements Exception {
  const LocalDatabaseException({
    required this.message,
  });

  final String message;
}
