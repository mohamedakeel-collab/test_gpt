import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/datasources/leave_type_remote_data_source.dart';
import '../../domain/entities/leave_type_entity.dart';
import '../../domain/repositories/leave_type_repository.dart';

@LazySingleton(as: LeaveTypeRepository)
class LeaveTypeRepositoryImpl implements LeaveTypeRepository {
  const LeaveTypeRepositoryImpl(this._remote);

  final LeaveTypeRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<LeaveTypeEntity>>> getLeaveTypes() {
    return _remote.getLeaveTypes();
  }
}
