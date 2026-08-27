part of '../imports/request_details_imports.dart';

@injectable
class RequestCommentsCubit extends AsyncCubit<List<CommentEntity>> {
  RequestCommentsCubit(this._useCase);

  final GetRequestCommentsUseCase _useCase;

  Future<void> getComments(int requestId) {
    return execute(() => _useCase(requestId));
  }
}
