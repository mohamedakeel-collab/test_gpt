part of '../imports/profile_imports.dart';

@injectable
class ProfileCubit extends AsyncCubit<LoginEntity> {
  ProfileCubit(this._useCase);

  final GetProfileUseCase _useCase;

  Future<void> getProfile() => execute(_useCase.call);
}
