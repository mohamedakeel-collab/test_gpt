/// Wire model of the created leave request (the `data` payload of
/// `POST /leave-requests/store`).
class NewRequestModel {
  const NewRequestModel({
    required this.id,
    this.employeeId,
    this.reviewerId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    this.duration,
    required this.reason,
    this.file,
    required this.status,
    required this.statusText,
    this.submittedAt,
  });

  factory NewRequestModel.fromJson(Map<String, dynamic> json) =>
      NewRequestModel(
        id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
        employeeId: int.tryParse(json['employee_id']?.toString() ?? ''),
        reviewerId: json['reviewer_id'] != null
            ? int.tryParse(json['reviewer_id'].toString())
            : null,
        duration: json['duration']?.toString(),
        leaveType: json['leave_type']?.toString() ?? '',
        startDate: json['start_date']?.toString() ?? '',
        endDate: json['end_date']?.toString() ?? '',
        reason: json['reason']?.toString() ?? '',
        file: json['file']?.toString(),
        status: json['status']?.toString() ?? '',
        statusText: json['status_text']?.toString() ?? '',
        submittedAt: json['submitted_at']?.toString(),
      );

  final int id;
  final int? employeeId;
  final int? reviewerId;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;
  final String? file;
  final String? duration;
  final String status;
  final String statusText;
  final String? submittedAt;
}