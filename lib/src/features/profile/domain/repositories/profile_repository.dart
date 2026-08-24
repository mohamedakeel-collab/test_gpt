import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../login/domain/entities/login_entity.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, LoginEntity>> getProfile();
}
