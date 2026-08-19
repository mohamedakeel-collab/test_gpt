part of '../imports/home_imports.dart';

/// Owns the Home dashboard data. Single one-shot fetch.
///
/// Pattern recap (from `core/state/async_cubit.dart`)
///   - `execute(() => useCase())` → emits Loading → Success/Failure
///     by folding the `Either<Failure, HomeEntity>`.
@injectable
class HomeCubit extends AsyncCubit<HomeEntity> {
  HomeCubit(this._getHome);

  final GetHomeUseCase _getHome;

  Future<void> fetchHome() {
    return execute(() => _getHome());
  }
}