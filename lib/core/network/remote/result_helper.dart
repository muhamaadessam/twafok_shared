import '../../error/failure.dart';

sealed class Result<T> {
  const Result();

  R fold<R>(
    R Function(Failure failure) onError,
    R Function(T data) onSuccess,
  ) =>
      switch (this) {
        Success(:final data) => onSuccess(data),
        Error(:final failure) => onError(failure),
      };
}

final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

final class Error<T> extends Result<T> {
  final Failure failure;

  const Error(this.failure);
}
