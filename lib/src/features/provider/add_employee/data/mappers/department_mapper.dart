import '../../domain/entities/department_entity.dart';
import '../models/department_model.dart';

extension DepartmentModelMapper on DepartmentModel {
  DepartmentEntity toEntity() => DepartmentEntity(
        id: id,
        name: name,
        managerId: managerId,
        employeesCount: employeesCount,
        managerName: managerName,
        phone: phone,
        position: position,
      );
}

extension DepartmentEntityMapper on DepartmentEntity {
  DepartmentModel toModel() => DepartmentModel(
        id: id,
        name: name,
        managerId: managerId,
        employeesCount: employeesCount,
        managerName: managerName,
        phone: phone,
        position: position,
      );
}
