part of '../imports/login_imports.dart';

/// Handles the login submit flow: calls [LoginUseCase], persists the
/// returned Sanctum token via [TokenStorage], and drives the
/// `AsyncState<LoginEntity>` that the UI renders.
///
/// Pattern recap
///   - `execute(() => useCase(...))` emits Loading → Success/Failure by
///     folding the `Either<Failure, LoginEntity>`.
///   - The token save lives *inside* the execute closure (before the success
///     state is emitted) so the UI never navigates on a case where the token
///     hasn't been persisted yet.
@injectable
class LoginCubit extends AsyncCubit<LoginEntity> {
  LoginCubit(this._login, this._tokenStorage);

  final LoginUseCase _login;
  final TokenStorage _tokenStorage;

  Future<void> login({
    required String login,
    required String password,
  }) {
    return execute(() async {
      final result = await _login(login: login, password: password);

      // Persist the token only on success. `fold` awaits both branches so a
      // failed keychain write still surfaces before navigation.
      await result.fold(
        (_) async {},
        (data) async => _tokenStorage.save(access: data.token),
      );

      return result;
    });
  }
}