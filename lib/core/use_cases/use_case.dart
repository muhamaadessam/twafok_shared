import 'package:equatable/equatable.dart';

import '../network/remote/result_helper.dart';

abstract class BaseUseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
