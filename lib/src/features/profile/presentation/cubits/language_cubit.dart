part of '../imports/profile_imports.dart';

@injectable
class LanguageCubit extends AsyncCubit<LoginEntity> {
  LanguageCubit(this._useCase);

  final SetLanguageUseCase _useCase;

  Future<void> changeLanguage(String language) {
    return execute(() => _useCase(language));
  }
}
