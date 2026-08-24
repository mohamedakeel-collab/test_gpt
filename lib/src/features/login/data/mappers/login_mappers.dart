import '../../../../core/shared/models/user_model.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../models/department_model.dart';
import '../models/employee_model.dart';
import '../models/login_model.dart';
import '../models/team_model.dart';

/// Maps between the data-layer models (wire shape) and the domain-layer
/// entities (clean shape). Lives in the **data** layer — domain code never
/// imports it; the data source uses `.toEntity()` before returning.
extension LoginModelMapper on LoginModel {
  LoginEntity toEntity() => LoginEntity(
    message: message,
    tokenType: tokenType,
    token: token,
    id: id,
    email: email,
    role: role,
    image: image,
    employee: employee?.toEntity(),
  );
}

extension EmployeeModelMapper on EmployeeModel {
  EmployeeEntity toEntity() => EmployeeEntity(
    id: id,
    fullName: fullName,
    phone: phone,
    position: position,
    departmentId: departmentId,
    teamId: teamId,
    managerId: managerId,
    remainingLeaveBalance: remainingLeaveBalance,
    leaveBalance: leaveBalance,
    balanceExpiration: balanceExpiration,
    permissionHours: permissionHours,
    department: department?.toEntity(),
    team: team?.toEntity(),
    manager: manager?.toEntity(),
  );
}

extension DepartmentModelMapper on DepartmentModel {
  DepartmentEntity toEntity() =>
      DepartmentEntity(id: id, name: name, managerId: managerId);
}

extension TeamModelMapper on TeamModel {
  TeamEntity toEntity() =>
      TeamEntity(id: id, teamName: teamName, leadId: leadId);
}

extension LoginEntityMapper on LoginEntity {
  UserModel toUserModel() {
    return UserModel(
      id: id.toString(),
      image: image,

      fullName: employee?.fullName ?? '',

      phoneNumber: employee?.phone ?? '',

      email: email,

      role: role,

      userType: _mapRole(role),

      position: employee?.position ?? '',

      department: employee?.department != null
          ? DepartmentModel(
              id: employee!.department!.id,
              name: employee!.department!.name,
              managerId: employee!.department!.managerId,
            )
          : null,

      team: employee?.team != null
          ? TeamModel(
              id: employee!.team!.id,
              teamName: employee!.team!.teamName,
              leadId: employee!.team!.leadId,
            )
          : null,

      remainingLeaveBalance: employee?.remainingLeaveBalance ?? 0,

      permissionHours: employee?.permissionHours ?? 0,

      allowNotify: false,

      token: token,
    );
  }

  int _mapRole(String role) {
    switch (role.toLowerCase()) {
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
