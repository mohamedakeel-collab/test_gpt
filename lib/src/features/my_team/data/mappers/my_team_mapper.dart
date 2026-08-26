import '../../../orders/data/mappers/orders_mapper.dart';
import '../../../orders/data/models/leave_request_model.dart';
import '../../../orders/domain/entities/leave_request_entity.dart';

extension MyTeamLeaveRequestListMapper on Iterable<LeaveRequestModel> {
  List<LeaveRequestEntity> toEntities() =>
      map((model) => model.toEntity()).toList();
}
