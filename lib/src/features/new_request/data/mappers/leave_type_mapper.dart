import '../../domain/entities/leave_type_entity.dart';
import '../models/leave_type_model.dart';

extension LeaveTypeMapper on LeaveTypeModel {
  LeaveTypeEntity toEntity() =>
      LeaveTypeEntity(id: id, name: name, translatedName: translatedName);
}
