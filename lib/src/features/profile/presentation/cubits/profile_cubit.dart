part of '../imports/profile_imports.dart';

@injectable
class ProfileCubit extends AsyncCubit<LoginEntity> {
  ProfileCubit(
      this._getProfile,
      this._userCubit,
      );

  final GetProfileUseCase _getProfile;
  final UserCubit _userCubit;


  Future<void> getProfile() async {
    emit(
      AsyncLoading<LoginEntity>(
        previous: lastData,
      ),
    );

    final result = await _getProfile();

    await result.fold(
          (failure) async {
        emit(
          AsyncFailure<LoginEntity>(
            failure,
            previous: lastData,
          ),
        );
      },

          (profile) async {
        setData(profile);

        await _userCubit.updateUser(
          profile.toUserModel(),
        );
      },
    );
  }
}