part of '../imports/request_details_imports.dart';

@injectable
class RequestCommentsCubit extends AsyncCubit<List<CommentEntity>> {
  RequestCommentsCubit(this._useCase, this._addCommentUseCase);

  final GetRequestCommentsUseCase _useCase;
  final AddRequestCommentUseCase _addCommentUseCase;
  bool _isAddingComment = false;

  bool get isAddingComment => _isAddingComment;

  Future<void> getComments(int requestId) {
    return execute(() => _useCase(requestId));
  }

  Future<void> addComment({
    required int requestId,
    required String comment,
  }) async {
    if (_isAddingComment) return;

    _isAddingComment = true;
    try {
      final current = lastData ?? const <CommentEntity>[];
      emit(AsyncLoading<List<CommentEntity>>(previous: current));

      final result = await _addCommentUseCase(requestId, comment);
      result.fold(
        (failure) =>
            emit(AsyncFailure<List<CommentEntity>>(failure, previous: current)),
        (newComment) => setData([...current, newComment]),
      );
    } finally {
      _isAddingComment = false;
    }
  }
}
