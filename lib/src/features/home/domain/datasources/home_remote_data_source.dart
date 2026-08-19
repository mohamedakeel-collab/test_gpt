import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/home_entity.dart';

/// Abstract contract for fetching the Home dashboard on a remote source.
///
/// Concrete implementation in `data/datasources/` extends `BaseRemoteSource`
/// (Dio + cancellation). Keeping the abstract here means use-cases and
/// tests can swap fakes in without touching the data layer.
abstract interface class HomeRemoteDataSource {
  Future<Either<Failure, HomeEntity>> getHome();
}