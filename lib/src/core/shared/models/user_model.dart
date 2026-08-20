import '../../../features/login/data/models/department_model.dart';
import '../../../features/login/data/models/team_model.dart';

class UserModel {

  final String id;

  final String image;

  final String fullName;

  final String phoneNumber;

  final String email;

  final String role;

  final int userType;

  final String position;

  final DepartmentModel? department;

  final TeamModel? team;

  final int remainingLeaveBalance;

  final int permissionHours;

  final bool allowNotify;

  final String? token;


  UserModel({
    required this.id,
    required this.image,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.userType,
    required this.position,
    required this.department,
    required this.team,
    required this.remainingLeaveBalance,
    required this.permissionHours,
    required this.allowNotify,
    required this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final employee =
    json['employee'] as Map<String, dynamic>?;


    return UserModel(

      id: (json['id'] ?? '').toString(),

      image: (json['image'] ?? '').toString(),

      email: (json['email'] ?? '').toString(),

      role: (json['role'] ?? '').toString(),


      fullName:
      (employee?['full_name'] ??
          json['full_name'] ??
          '')
          .toString(),


      phoneNumber:
      (employee?['phone'] ??
          json['phone_number'] ??
          '')
          .toString(),


      position:
      (employee?['position'] ?? '')
          .toString(),


      userType:
      _mapRole(json['role']),


      department:
      employee?['department'] != null
          ? DepartmentModel.fromJson(
        employee!['department']
        as Map<String, dynamic>,
      )
          : null,


      team:
      employee?['team'] != null
          ? TeamModel.fromJson(
        employee!['team']
        as Map<String, dynamic>,
      )
          : null,


      remainingLeaveBalance:
      _toInt(
        employee?['remaining_leave_balance'],
      ),


      permissionHours:
      _toInt(
        employee?['permission_hours'],
      ),


      allowNotify: false,


      token:
      (json['token'] ?? json['access_token'])
          ?.toString(),

    );
  }
  factory UserModel.initial() => UserModel(

    id: '',

    image: '',

    fullName: '',

    phoneNumber: '',

    email: '',

    role: '',

    userType: 0,

    position: '',

    department: null,

    team: null,

    remainingLeaveBalance: 0,

    permissionHours: 0,

    allowNotify: false,

    token: null,

  );
  Map<String, dynamic> toJson() {

    return {

      'id': id,

      'image': image,

      'full_name': fullName,

      'phone_number': phoneNumber,

      'email': email,

      'role': role,

      'user_type': userType,

      'position': position,


      'department': department?.toJson(),


      'team': team?.toJson(),


      'remaining_leave_balance':
      remainingLeaveBalance,


      'permission_hours':
      permissionHours,


      'allow_notify':
      allowNotify,


    };
  }
  static int _toInt(dynamic value) {
    if (value is int) return value;

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(
      value?.toString() ?? '',
    ) ??
        0;
  }


  static int _mapRole(dynamic role) {

    switch(role?.toString().toLowerCase()) {

      case 'manager':
        return 2;

      case 'hr':
        return 3;

      case 'employee':
        return 1;

      default:
        return 0;
    }
  }
}