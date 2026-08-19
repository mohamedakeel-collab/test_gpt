import 'package:equatable/equatable.dart';

/// Pure domain object — the latest attendance record on the home dashboard.
class AttendanceEntity extends Equatable {
  final int id;
  final int employeeId;
  final int? leaveRequestId;
  final String? checkIn;
  final String? checkOut;
  final String status;
  final String locationGps;
  final double duration;
  final String dayName;

  const AttendanceEntity({
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

  @override
  List<Object?> get props => [
        id,
        employeeId,
        leaveRequestId,
        checkIn,
        checkOut,
        status,
        locationGps,
        duration,
        dayName,
      ];
}