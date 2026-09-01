import 'package:equatable/equatable.dart';

class EmployeeDetailsEntity extends Equatable {
  const EmployeeDetailsEntity({
    required this.id,
    required this.fullName,
    required this.image,
    required this.phone,
    required this.position,
    required this.email,
    required this.role,
    required this.department,
    required this.team,
    required this.manager,
    required this.remainingLeaveBalance,
    required this.leaveBalance,
    required this.permissionHours,
    required this.leaveRequests,
    required this.attendanceRecords,
  });

  final int id;
  final String fullName;
  final String image;
  final String phone;
  final String position;
  final String email;
  final String role;
  final EmployeeDetailsDepartmentEntity department;
  final EmployeeDetailsTeamEntity team;
  final EmployeeDetailsManagerEntity manager;
  final int remainingLeaveBalance;
  final int leaveBalance;
  final int permissionHours;
  final List<EmployeeDetailsLeaveRequestEntity> leaveRequests;
  final List<EmployeeDetailsAttendanceEntity> attendanceRecords;

  factory EmployeeDetailsEntity.initial() => const EmployeeDetailsEntity(
        id: 0,
        fullName: '',
        image: '',
        phone: '',
        position: '',
        email: '',
        role: '',
        department: EmployeeDetailsDepartmentEntity(id: 0, name: ''),
        team: EmployeeDetailsTeamEntity(id: 0, name: ''),
        manager: EmployeeDetailsManagerEntity(id: 0, name: ''),
        remainingLeaveBalance: 0,
        leaveBalance: 0,
        permissionHours: 0,
        leaveRequests: [],
        attendanceRecords: [],
      );

  @override
  List<Object?> get props => [
        id,
        fullName,
        image,
        phone,
        position,
        email,
        role,
        department,
        team,
        manager,
        remainingLeaveBalance,
        leaveBalance,
        permissionHours,
        leaveRequests,
        attendanceRecords,
      ];
}

class EmployeeDetailsDepartmentEntity extends Equatable {
  const EmployeeDetailsDepartmentEntity({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class EmployeeDetailsTeamEntity extends Equatable {
  const EmployeeDetailsTeamEntity({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class EmployeeDetailsManagerEntity extends Equatable {
  const EmployeeDetailsManagerEntity({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class EmployeeDetailsLeaveRequestEntity extends Equatable {
  const EmployeeDetailsLeaveRequestEntity({
    required this.id,
    required this.requestType,
    required this.date,
    required this.duration,
    required this.reason,
    required this.status,
    required this.statusText,
  });


  final int id;
  final String requestType;
  final String date;
  final String duration;
  final String reason;
  final String status;
  final String statusText;


  @override
  List<Object?> get props => [
    id,
    requestType,
    date,
    duration,
    reason,
    status,
    statusText,
  ];
}

class EmployeeDetailsAttendanceEntity extends Equatable {
  const EmployeeDetailsAttendanceEntity({
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.duration,
  });

  final String checkIn;
  final String checkOut;
  final String status;
  final String duration;

  @override
  List<Object?> get props => [checkIn, checkOut, status, duration];
}
