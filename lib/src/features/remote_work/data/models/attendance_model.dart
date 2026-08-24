import '../../../../core/shared/extensions/json_extensions.dart';

class AttendanceModel {
  const AttendanceModel({
    required this.id,
    required this.employeeId,
    required this.checkInDate,
    required this.checkInTime,
    required this.checkOutDate,
    required this.checkOutTime,
    required this.status,
    required this.locationGps,
    required this.duration,
    required this.dayName,
    this.leaveRequestId,
  });

  final int id;
  final int employeeId;
  final int? leaveRequestId;
  final String checkInDate;
  final String checkInTime;
  final String checkOutDate;
  final String checkOutTime;
  final String status;
  final String locationGps;
  final double duration;
  final String dayName;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json.getInt('id'),
        employeeId: json.getInt('employee_id'),
        leaveRequestId: json.getIntOrNull('leave_request_id'),
        checkInDate: json.getString('check_in_date'),
        checkInTime: json.getString('check_in_time'),
        checkOutDate: json.getString('check_out_date'),
        checkOutTime: json.getString('check_out_time'),
        status: json.getString('status'),
        locationGps: json.getString('location_gps'),
        duration: json.getDouble('duration'),
        dayName: json.getString('day_name'),
      );
}
