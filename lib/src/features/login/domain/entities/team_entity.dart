import 'package:equatable/equatable.dart';

/// Pure domain object for a team — no `fromJson`, no Dio, no Flutter.
///
/// Serialization is handled by `TeamModel` in `data/models/` and the
/// `TeamMapper` extension in `data/mappers/`.
class TeamEntity extends Equatable {
  final int id;
  final String teamName;
  final int? leadId;

  const TeamEntity({
    required this.id,
    required this.teamName,
    this.leadId,
  });

  factory TeamEntity.initial() => const TeamEntity(
        id: 0,
        teamName: '',
      );

  TeamEntity copyWith({
    int? id,
    String? teamName,
    int? leadId,
  }) {
    return TeamEntity(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      leadId: leadId ?? this.leadId,
    );
  }

  @override
  List<Object?> get props => [id, teamName, leadId];
}