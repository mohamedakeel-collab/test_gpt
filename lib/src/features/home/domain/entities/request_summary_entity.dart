import 'package:equatable/equatable.dart';

/// Pure domain object — counts of the current user's requests.
class RequestSummaryEntity extends Equatable {
  final int total;
  final int pending;
  final int approved;
  final int rejected;

  const RequestSummaryEntity({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  /// Placeholder used while the screen lays out before data arrives.
  factory RequestSummaryEntity.initial() => const RequestSummaryEntity(
        total: 0,
        pending: 0,
        approved: 0,
        rejected: 0,
      );

  @override
  List<Object?> get props => [total, pending, approved, rejected];
}