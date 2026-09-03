import 'employee_details_model.dart';

class ReviewerDetailsModel extends EmployeeDetailsModel {
  const ReviewerDetailsModel({
    required super.id,
    required super.fullName,
    required super.phone,
    required super.position,
    required super.remainingLeaveBalance,
    required super.leaveBalance,
    required super.permissionHours,
    super.image,
  });

  factory ReviewerDetailsModel.fromJson(Map<String, dynamic> json) {
    final employee = EmployeeDetailsModel.fromJson(json);
    return ReviewerDetailsModel(
      id: employee.id,
      fullName: employee.fullName,
      remainingLeaveBalance: employee.remainingLeaveBalance,
      phone: employee.phone,
      position: employee.position,
      leaveBalance: employee.leaveBalance,
      permissionHours: employee.permissionHours,
      image: employee.image,
    );
  }
}
