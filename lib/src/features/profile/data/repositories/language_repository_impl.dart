import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../../login/data/mappers/login_mappers.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../domain/repositories/language_repository.dart';
import '../datasources/language_remote_data_source.dart';

@LazySingleton(as: LanguageRepository)
class LanguageRepositoryImpl implements LanguageRepository {
  const LanguageRepositoryImpl(this._remote);

  final LanguageRemoteDataSource _remote;

  @override
  Future<Either<Failure, LoginEntity>> setLanguage(String language) async {
    final result = await _remote.setLanguage(language);
    return result.map((model) => model.toEntity());
  }
}
