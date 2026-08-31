import '../../domain/entities/employee_entity.dart';
import '../models/employee_model.dart';

extension EmployeeModelMapper on EmployeeModel {
  EmployeeEntity toEntity() => EmployeeEntity(
        id: id,
        fullName: fullName,
        image: image,
        phone: phone,
        position: position,
        role: role,
        department: department,
        hasPendingRequests: hasPendingRequests,
      );
}

extension EmployeeEntityMapper on EmployeeEntity {
  EmployeeModel toModel() => EmployeeModel(
        id: id,
        fullName: fullName,
        image: image,
        phone: phone,
        position: position,
        role: role,
        department: department,
        hasPendingRequests: hasPendingRequests,
      );
}
