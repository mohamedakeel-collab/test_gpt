import '../../../employees/domain/entities/employee_entity.dart';
import '../models/employee_create_model.dart';

extension EmployeeCreateModelMapper on EmployeeCreateModel {
  EmployeeEntity toEntity() => EmployeeEntity(
        id: id,
        fullName: fullName,
        image: image,
        phone: phone,
        position: position,
        role: role,
        department: '',
        hasPendingRequests: false,
      );
}
