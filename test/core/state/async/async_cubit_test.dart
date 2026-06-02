import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arch_base/src/core/network/error/failures.dart';
import 'package:clean_arch_base/src/core/state/async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class _CounterCubit extends AsyncCubit<int> {}

void main() {
  group('AsyncCubit', () {
    test('starts in AsyncInitial', () {
      expect(_CounterCubit().state, isA<AsyncInitial<int>>());
    });

    blocTest<_CounterCubit, AsyncState<int>>(
      'execute success emits Loading -> Success',
      build: _CounterCubit.new,
      act: (c) => c.execute(() async => const Right(5)),
      expect: () => [
        const AsyncLoading<int>(),
        const AsyncSuccess<int>(5),
      ],
    );

    blocTest<_CounterCubit, AsyncState<int>>(
      'execute failure emits Loading -> Failure',
      build: _CounterCubit.new,
      act: (c) => c.execute(() async => const Left(NetworkFailure())),
      expect: () => [
        const AsyncLoading<int>(),
        const AsyncFailure<int>(NetworkFailure()),
      ],
    );

    blocTest<_CounterCubit, AsyncState<int>>(
      'CancelledFailure is silent (only Loading is emitted)',
      build: _CounterCubit.new,
      act: (c) => c.execute(() async => const Left(CancelledFailure())),
      expect: () => [const AsyncLoading<int>()],
    );

    blocTest<_CounterCubit, AsyncState<int>>(
      'setData emits Success without re-fetch',
      build: _CounterCubit.new,
      act: (c) => c.setData(9),
      expect: () => [const AsyncSuccess<int>(9)],
    );

    blocTest<_CounterCubit, AsyncState<int>>(
      'setFailure emits Failure',
      build: _CounterCubit.new,
      act: (c) => c.setFailure(const ServerFailure()),
      expect: () => [const AsyncFailure<int>(ServerFailure())],
    );

    blocTest<_CounterCubit, AsyncState<int>>(
      'keeps last data as previous after a later failure',
      build: _CounterCubit.new,
      act: (c) async {
        await c.execute(() async => const Right(7));
        await c.execute(() async => const Left(NetworkFailure()));
      },
      expect: () => [
        const AsyncLoading<int>(),
        const AsyncSuccess<int>(7),
        const AsyncLoading<int>(previous: 7),
        const AsyncFailure<int>(NetworkFailure(), previous: 7),
      ],
    );
  });
}
