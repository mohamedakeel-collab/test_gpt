import '../../../../../core/shared/extensions/json_extensions.dart';
import 'employee_details_department_model.dart';
import 'employee_details_manager_model.dart';
import 'employee_details_team_model.dart';

class EmployeeDetailsModel {
  const EmployeeDetailsModel({
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
  final EmployeeDetailsDepartmentModel department;
  final EmployeeDetailsTeamModel team;
  final EmployeeDetailsManagerModel manager;
  final int remainingLeaveBalance;
  final int leaveBalance;
  final int permissionHours;
  final List<EmployeeDetailsLeaveRequestModel> leaveRequests;
  final List<EmployeeDetailsAttendanceModel> attendanceRecords;

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) {
    final user = json.getMap('user');

    return EmployeeDetailsModel(
      id: json.getInt('id'),
      fullName: json.getString('full_name'),
      image: user.getString('image'),
      phone: json.getString('phone'),
      position: json.getString('position'),
      email: user.getString('email'),
      role: user.getString('role'),
      department: EmployeeDetailsDepartmentModel.fromJson(
        json.getMap('department'),
      ),
      team: EmployeeDetailsTeamModel.fromJson(json.getMap('team')),
      manager: EmployeeDetailsManagerModel.fromJson(json.getMap('manager')),
      remainingLeaveBalance: json.getInt('remaining_leave_balance'),
      leaveBalance: json.getInt('leave_balance'),
      permissionHours: json.getInt('permission_hours'),
      leaveRequests: json
          .getObjectList('leave_requests', EmployeeDetailsLeaveRequestModel.fromJson),
      attendanceRecords: json.getObjectList(
        'attendance_records',
        EmployeeDetailsAttendanceModel.fromJson,
      ),
    );
  }
}

class EmployeeDetailsLeaveRequestModel {

  const EmployeeDetailsLeaveRequestModel({
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



  factory EmployeeDetailsLeaveRequestModel.fromJson(
      Map<String,dynamic> json,
      ) {

    return EmployeeDetailsLeaveRequestModel(

      id: json.getInt('id'),

      requestType: json.getString(
        'leave_type',
      ),

      date: json.getString(
        'start_date',
      ),

      duration: json.getString(
        'duration',
      ),

      reason: json.getString(
        'reason',
      ),

      status: json.getString(
        'status',
      ),

      statusText: json.getString(
        'status_text',
      ),

    );
  }
}

class EmployeeDetailsAttendanceModel {
  const EmployeeDetailsAttendanceModel({
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.duration,
  });

  final String checkIn;
  final String checkOut;
  final String status;
  final String duration;

  factory EmployeeDetailsAttendanceModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsAttendanceModel(
      checkIn: json.getString('check_in', fallback: json.getString('check_in_time')),
      checkOut: json.getString('check_out', fallback: json.getString('check_out_time')),
      status: json.getString('status'),
      duration: json.getString('duration'),
    );
  }
}
