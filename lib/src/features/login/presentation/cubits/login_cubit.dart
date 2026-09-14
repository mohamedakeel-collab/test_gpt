part of '../imports/login_imports.dart';

@injectable
class LoginCubit extends AsyncCubit<LoginEntity> {
  LoginCubit(
      this._login,
      this._tokenStorage,
      this._userCubit,
      );

  final UserCubit _userCubit;
  final LoginUseCase _login;
  final TokenStorage _tokenStorage;


  Future<void> login({
    required String login,
    required String password,
  }) async {

    emit(const AsyncLoading<LoginEntity>());


    final result = await _login(
      login: login,
      password: password,
    );


    await result.fold(

          (failure) async {

        emit(
          AsyncFailure<LoginEntity>(
            failure,
          ),
        );

      },


          (data) async {

        final user = data.toUserModel();


        debugPrint(
          'LOGIN USER ROLE ===== ${user.role}',
        );


        await _tokenStorage.save(
          access: data.token,
        );


        await _userCubit.setUserLoggedIn(
          user: user,
          token: data.token,
        );


        debugPrint(
          'USER CUBIT ROLE ===== ${_userCubit.user.role}',
        );


        emit(
          AsyncSuccess<LoginEntity>(
            data,
          ),
        );

      },

    );
  }
}