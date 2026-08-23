part of '../imports/new_request_imports.dart';

/// Owns the create-leave-request flow. Single submit action.
///
/// Pattern recap (from `core/state/async_cubit.dart`)
///   - `execute(() => useCase(params))` → emits Loading → Success/Failure
///     by folding the `Either<Failure, NewRequestResultEntity>`.
@injectable
class NewRequestCubit extends AsyncCubit<NewRequestResultEntity> {
  NewRequestCubit(this._createRequest, this._updateRequest);

  final CreateNewRequestUseCase _createRequest;
  final UpdateRequestUseCase _updateRequest;

  Future<void> submit({
    required RequestMode mode,
    int? requestId,
    required CreateNewRequestParams params,
  }) {
    return execute(
      () => mode == RequestMode.edit
          ? _updateRequest(requestId!, params)
          : _createRequest(params),
    );
  }
}
