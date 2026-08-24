import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  const AttendanceEntity({
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

  bool get isActive => checkInTime.isNotEmpty && checkOutTime.isEmpty;

  factory AttendanceEntity.initial() => const AttendanceEntity(
    id: 0,
    employeeId: 0,
    checkInDate: '',
    checkInTime: '',
    checkOutDate: '',
    checkOutTime: '',
    status: '',
    locationGps: '',
    duration: 0,
    dayName: '',
  );

  @override
  List<Object?> get props => [
    id,
    employeeId,
    leaveRequestId,
    checkInDate,
    checkInTime,
    checkOutDate,
    checkOutTime,
    status,
    locationGps,
    duration,
    dayName,
  ];
}
