import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error/failures.dart';
import '../repositories/logout_repository.dart';

@injectable
class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final LogOutRepository _repository;

  Future<Either<Failure, String>> call() {
    return _repository.logout();
  }
}
