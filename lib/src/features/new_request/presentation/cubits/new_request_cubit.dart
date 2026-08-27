part of '../imports/new_request_imports.dart';

/// Owns the create-leave-request flow. Single submit action.
///
/// Pattern recap (from `core/state/async_cubit.dart`)
///   - `execute(() => useCase(params))` → emits Loading → Success/Failure
///     by folding the `Either<Failure, NewRequestResultEntity>`.
@injectable
class NewRequestCubit extends AsyncCubit<NewRequestResultEntity> {
  NewRequestCubit(
    this._createRequest,
    this._updateRequest,
    this._updateProviderRequest,
  );

  final CreateNewRequestUseCase _createRequest;
  final UpdateRequestUseCase _updateRequest;
  final UpdateProviderRequestUseCase _updateProviderRequest;

  Future<void> submit({
    required RequestMode mode,
    int? requestId,
    required CreateNewRequestParams params,
  }) {
    return execute(
      () => switch (mode) {
        RequestMode.add => _createRequest(params),
        RequestMode.edit => _updateRequest(requestId!, params),
        RequestMode.editProvider => _updateProviderRequest(requestId!, params),
      },
    );
  }
}
