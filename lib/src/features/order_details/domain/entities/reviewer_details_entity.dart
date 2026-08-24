import 'employee_details_entity.dart';

class ReviewerDetailsEntity extends EmployeeDetailsEntity {
  const ReviewerDetailsEntity({
    required super.id,
    required super.fullName,
    required super.phone,
    required super.position,
    required super.leaveBalance,
    required super.permissionHours,
    super.image,
  });

  factory ReviewerDetailsEntity.initial() => const ReviewerDetailsEntity(
    id: 0,
    fullName: '',
    phone: '',
    position: '',
    leaveBalance: 0,
    permissionHours: 0,
  );
}
