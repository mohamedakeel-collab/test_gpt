import 'package:equatable/equatable.dart';

/// Pure domain object — the team nested inside the home employee.
class TeamEntity extends Equatable {
  final int id;
  final String teamName;
  final int leadId;

  const TeamEntity({
    required this.id,
    required this.teamName,
    required this.leadId,
  });

  @override
  List<Object?> get props => [id, teamName, leadId];
}