import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base class for all UseCases in the application.
/// T = return type
/// Params = parameters passed to the usecase
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use this when no parameters are needed.
class NoParams {}
