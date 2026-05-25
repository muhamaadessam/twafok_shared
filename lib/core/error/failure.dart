import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure(super.message);
}

class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure(super.message);
}

class ConnectionFailure extends NetworkFailure {
  const ConnectionFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class BadRequestFailure extends ServerFailure {
  const BadRequestFailure(super.message);
}

class UnauthorizedFailure extends ServerFailure {
  const UnauthorizedFailure(super.message);
}

class ForbiddenFailure extends ServerFailure {
  const ForbiddenFailure(super.message);
}

class NotFoundFailure extends ServerFailure {
  const NotFoundFailure(super.message);
}

class LocalFailure extends Failure {
  const LocalFailure(super.message);
}

class CacheFailure extends LocalFailure {
  const CacheFailure(super.message);
}

class DatabaseFailure extends LocalFailure {
  const DatabaseFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
