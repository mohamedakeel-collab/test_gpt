import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `team` object nested inside the home employee.
class HomeTeamModel {
  final int id;
  final String teamName;
  final int leadId;

  const HomeTeamModel({
    required this.id,
    required this.teamName,
    required this.leadId,
  });

  factory HomeTeamModel.fromJson(Map<String, dynamic> json) => HomeTeamModel(
        id: json.getInt('id'),
        teamName: json.getString('team_name'),
        leadId: json.getInt('lead_id'),
      );
}