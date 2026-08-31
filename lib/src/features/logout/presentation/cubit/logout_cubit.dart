part of '../imports/logout_imports.dart';

@injectable
class LogoutCubit extends AsyncCubit<String> {

  LogoutCubit(
      this._useCase,
      this._userCubit,
      );


  final LogoutUseCase _useCase;
  final UserCubit _userCubit;


  Future<void> logout() {

    return execute(() async {

      final result = await _useCase();


      await result.fold(
            (_) async {},

            (_) async {
          await _userCubit.logout();
        },
      );


      return result;
    });
  }
}
