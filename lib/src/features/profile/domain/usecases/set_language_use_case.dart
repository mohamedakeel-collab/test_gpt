import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../repositories/language_repository.dart';

@injectable
class SetLanguageUseCase {
  const SetLanguageUseCase(this.repository);

  final LanguageRepository repository;

  Future<Either<Failure, LoginEntity>> call(String language) {
    return repository.setLanguage(language);
  }
}
