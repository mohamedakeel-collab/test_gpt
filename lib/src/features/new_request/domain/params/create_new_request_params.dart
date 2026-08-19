import 'dart:io';

/// Input of `POST /leave-requests/store` (multipart/form-data).
///
/// Pure Dart value object. `file` is optional and validated client-side
/// (extension + max 5 MB) before this is ever built.
class CreateNewRequestParams {
  const CreateNewRequestParams({
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.file,
  });

  /// One of: `leave`, `permission`, `remote`, `sick`.
  final String leaveType;

  /// `YYYY-MM-DD HH:mm:ss` is produced in the data layer.
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final File? file;
}