part of '../imports/logout_imports.dart';

@injectable
class LogoutCubit extends AsyncCubit<String> {
  LogoutCubit(this._useCase);

  final LogoutUseCase _useCase;

  Future<void> logout() {
    return execute(_useCase.call);
  }
}
