import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../repositories/profile_repository.dart';

@injectable
class GetProfileUseCase {
  const GetProfileUseCase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, LoginEntity>> call() {
    return repository.getProfile();
  }
}
