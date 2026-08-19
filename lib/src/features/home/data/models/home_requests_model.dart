import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `requests` object returned by the Home API.
class HomeRequestsModel {
  final int total;
  final int pending;
  final int approved;
  final int rejected;

  const HomeRequestsModel({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  factory HomeRequestsModel.fromJson(Map<String, dynamic> json) =>
      HomeRequestsModel(
        total: json.getInt('total'),
        pending: json.getInt('pending'),
        approved: json.getInt('approved'),
        rejected: json.getInt('rejected'),
      );
}