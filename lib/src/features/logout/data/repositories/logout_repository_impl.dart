import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/repositories/logout_repository.dart';
import '../datasources/logout_remote_data_source.dart';

@LazySingleton(as: LogOutRepository)
class LogOutRepositoryImpl implements LogOutRepository {
  const LogOutRepositoryImpl(this._remote);

  final LogOutRemoteDataSource _remote;

  @override
  Future<Either<Failure, String>> logout() {
    return _remote.logout();
  }
}
