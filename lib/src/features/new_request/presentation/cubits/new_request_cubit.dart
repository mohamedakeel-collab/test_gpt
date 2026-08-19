part of '../imports/new_request_imports.dart';

/// Owns the create-leave-request flow. Single submit action.
///
/// Pattern recap (from `core/state/async_cubit.dart`)
///   - `execute(() => useCase(params))` → emits Loading → Success/Failure
///     by folding the `Either<Failure, NewRequestResultEntity>`.
@injectable
class NewRequestCubit extends AsyncCubit<NewRequestResultEntity> {
  NewRequestCubit(this._createRequest);

  final CreateNewRequestUseCase _createRequest;

  Future<void> submit(CreateNewRequestParams params) {
    return execute(() => _createRequest(params));
  }
}