import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

/// Thin use-case wrapping the single `getHome` repository call.
///
/// Returns `Either<Failure, HomeEntity>` — the cubit `.fold`s on it via
/// `AsyncCubit.execute`.
@injectable
class GetHomeUseCase {
  const GetHomeUseCase(this._repo);

  final HomeRepository _repo;

  /// Callable syntax: `useCase()`.
  Future<Either<Failure, HomeEntity>> call() => _repo.getHome();
}