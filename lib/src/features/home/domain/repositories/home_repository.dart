import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/home_entity.dart';

/// Abstract repository — the use-case-facing surface of the Home feature.
///
/// Use-cases depend on this, not on the data source directly, so we can
/// add cross-cutting concerns (caching, retry policy, logging) inside
/// `HomeRepositoryImpl` without touching anyone's code.
abstract interface class HomeRepository {
  Future<Either<Failure, HomeEntity>> getHome();
}