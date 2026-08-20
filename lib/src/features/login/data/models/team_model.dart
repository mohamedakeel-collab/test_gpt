import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `team` object nested inside the employee.
class TeamModel {
  final int id;
  final String teamName;
  final int? leadId;

  const TeamModel({required this.id, required this.teamName, this.leadId});

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    id: json.getInt('id'),
    teamName: json.getString('team_name'),
    leadId: json.getIntOrNull('lead_id'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'team_name': teamName,
    'lead_id': leadId,
  };
}
