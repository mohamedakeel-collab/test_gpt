import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';

abstract interface class LogOutRepository {
  Future<Either<Failure, String>> logout();
}
