import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/datasources/home_remote_data_source.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';

/// Concrete repository.
///
/// Right now it's a thin pass-through — the remote data source already
/// returns `Either<Failure, T>`. The moment we add a second data source
/// (e.g. a Hive cache, an in-memory mirror) this class is where the
/// "try cache then remote" logic lives — without anyone upstream caring.
@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remote);

  final HomeRemoteDataSource _remote;

  @override
  Future<Either<Failure, HomeEntity>> getHome() => _remote.getHome();
}