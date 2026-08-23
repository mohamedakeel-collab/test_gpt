import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/error/failures.dart';
import 'async_state.dart';

/// Base cubit for one-shot async data (GET single / GET list / mutation).
/// Concrete cubits only describe the actual call — usually by delegating
/// to a use-case that returns `Either<Failure, T>`.
///
/// Workflow
///   ```dart
///   @injectable
///   class XCubit extends AsyncCubit<List<X>> {
///     XCubit(this._useCase);
///     final GetXListUseCase _useCase;
///
///     Future<void> fetch() => execute(() => _useCase());
///   }
///   ```
abstract class AsyncCubit<T> extends Cubit<AsyncState<T>> {
  AsyncCubit() : super(const AsyncInitial());

  /// Last successful payload — kept across loading/error states so the UI
  /// can render the old data while refreshing.
  T? _last;
  T? get lastData => _last;

  void clearData() {
    _last = null;
    emit(AsyncLoading<T>(previous: null));
  }
  /// Run the call, emit Loading → Success/Failure based on the [Either].
  ///
  /// `CancelledFailure` is silent — it means a newer call superseded this
  /// one, so the cubit keeps its current state instead of flashing an error.
  Future<void> execute(Future<Either<Failure, T>> Function() call) async {
    emit(AsyncLoading<T>(previous: _last));
    final result = await call();
    result.fold(
      (failure) {
        if (failure is CancelledFailure) return;
        emit(AsyncFailure<T>(failure, previous: _last));
      },
      (data) {
        _last = data;
        emit(AsyncSuccess<T>(data));
      },
    );
  }

  /// Local update without re-fetching (the CRUD rule: never re-fetch when
  /// you already know the new value — add/edit/delete locally).
  void setData(T data) {
    _last = data;
    emit(AsyncSuccess<T>(data));
  }

  /// Force a failure state (e.g. a validation error the cubit composes
  /// itself, with no API call behind it).
  void setFailure(Failure failure) {
    emit(AsyncFailure<T>(failure, previous: _last));
  }
}
