import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../login/domain/entities/login_entity.dart';

abstract interface class LanguageRepository {
  Future<Either<Failure, LoginEntity>> setLanguage(String language);
}
