import '../../domain/entities/attendance_entity.dart';
import '../models/attendance_model.dart';

extension AttendanceModelMapper on AttendanceModel {
  AttendanceEntity toEntity() => AttendanceEntity(
    id: id,
    employeeId: employeeId,
    leaveRequestId: leaveRequestId,
    checkInDate: checkInDate,
    checkInTime: checkInTime,
    checkOutDate: checkOutDate,
    checkOutTime: checkOutTime,
    status: status,
    locationGps: locationGps,
    duration: duration,
    dayName: dayName,
  );
}
