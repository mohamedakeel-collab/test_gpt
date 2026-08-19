import '../../../../core/shared/extensions/json_extensions.dart';

/// DTO mirroring the `latest_attendance` object returned by the Home API.
class HomeAttendanceModel {
  final int id;
  final int employeeId;
  final int? leaveRequestId;
  final String? checkIn;
  final String? checkOut;
  final String status;
  final String locationGps;
  final double duration;
  final String dayName;

  const HomeAttendanceModel({
    required this.id,
    required this.employeeId,
    required this.status,
    required this.locationGps,
    required this.duration,
    required this.dayName,
    this.leaveRequestId,
    this.checkIn,
    this.checkOut,
  });

  factory HomeAttendanceModel.fromJson(Map<String, dynamic> json) =>
      HomeAttendanceModel(
        id: json.getInt('id'),
        employeeId: json.getInt('employee_id'),
        leaveRequestId: json.getIntOrNull('leave_request_id'),
        checkIn: json.getStringOrNull('check_in'),
        checkOut: json.getStringOrNull('check_out'),
        status: json.getString('status'),
        locationGps: json.getString('location_gps'),
        duration: json.getDouble('duration'),
        dayName: json.getString('day_name'),
      );
}