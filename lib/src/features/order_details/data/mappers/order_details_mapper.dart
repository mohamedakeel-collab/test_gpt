import '../../domain/entities/attendance_record_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/employee_details_entity.dart';
import '../../domain/entities/leave_request_details_entity.dart';
import '../../domain/entities/reviewer_details_entity.dart';
import '../models/attendance_record_model.dart';
import '../models/comment_model.dart';
import '../models/employee_details_model.dart';
import '../models/order_details_model.dart';
import '../models/reviewer_details_model.dart';

extension OrderDetailsModelMapper on OrderDetailsModel {
  LeaveRequestDetailsEntity toEntity() => LeaveRequestDetailsEntity(
    id: id,
    employeeId: employeeId,
    reviewerId: reviewerId,
    leaveType: leaveType,
    startDate: startDate,
    startTime: startTime,
    endDate: endDate,
    endTime: endTime,
    duration: duration,
    reason: reason,
    file: file,
    status: status,
    statusText: statusText,
    submittedAt: submittedAt,
    reviewedAt: reviewedAt,
    employee: employee.toEntity(),
    reviewer: reviewer?.toEntity(),
    comments: comments.map((comment) => comment.toEntity()).toList(),
    attendanceRecords: attendanceRecords
        .map((record) => record.toEntity())
        .toList(),
  );
}

extension EmployeeDetailsModelMapper on EmployeeDetailsModel {
  EmployeeDetailsEntity toEntity() => EmployeeDetailsEntity(
    id: id,
    fullName: fullName,
    phone: phone,
    position: position,
    leaveBalance: leaveBalance,
    permissionHours: permissionHours,
    image: image,
  );
}

extension ReviewerDetailsModelMapper on ReviewerDetailsModel {
  ReviewerDetailsEntity toEntity() => ReviewerDetailsEntity(
    id: id,
    fullName: fullName,
    phone: phone,
    position: position,
    leaveBalance: leaveBalance,
    permissionHours: permissionHours,
    image: image,
  );
}

extension CommentModelMapper on CommentModel {
  CommentEntity toEntity() => CommentEntity(
    id: id,
    authorFullName: authorFullName,
    commentText: commentText,
    createdAt: createdAt,
  );
}

extension AttendanceRecordModelMapper on AttendanceRecordModel {
  AttendanceRecordEntity toEntity() => AttendanceRecordEntity(
    id: id,
    date: date,
    checkIn: checkIn,
    checkOut: checkOut,
  );
}
