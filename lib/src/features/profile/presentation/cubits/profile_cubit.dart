part of '../imports/profile_imports.dart';

@injectable
class ProfileCubit extends AsyncCubit<LoginEntity> {
  ProfileCubit(this._getProfile);

  final GetProfileUseCase _getProfile;

  Future<void> getProfile() async {
    emit(AsyncLoading<LoginEntity>(previous: lastData));

    final result = await _getProfile();

    result.fold(
      (failure) {
        emit(AsyncFailure<LoginEntity>(failure, previous: lastData));
      },

      (profile) {
        setData(profile);
      },
    );
  }
}
