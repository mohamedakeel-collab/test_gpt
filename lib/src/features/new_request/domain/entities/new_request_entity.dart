/// The leave request created by the API (the `data` payload of
/// `POST /leave-requests/store`).
///
/// Pure Dart entity — no JSON, no Dio, no API dependency. Field names are
/// the server's snake_case keys, mapped via the data layer's models.
class NewRequestEntity {
  const NewRequestEntity({
    required this.id,
    this.employeeId,
    this.reviewerId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.file,
    required this.status,
    required this.statusText,
    this.duration,
    this.submittedAt,
  });

  final int id;
  final int? employeeId;
  final int? reviewerId;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String? duration;
  final String reason;
  final String? file;
  final String status;
  final String statusText;
  final String? submittedAt;
}