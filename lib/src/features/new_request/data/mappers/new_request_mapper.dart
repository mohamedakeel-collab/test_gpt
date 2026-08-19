import '../../domain/entities/new_request_entity.dart';
import '../../domain/entities/new_request_result_entity.dart';
import '../models/new_request_model.dart';
import '../models/new_request_response_model.dart';

extension NewRequestModelMapper on NewRequestModel {
  NewRequestEntity toEntity() => NewRequestEntity(
        id: id,
        employeeId: employeeId,
        reviewerId: reviewerId,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        file: file,
        status: status,
        statusText: statusText,
        submittedAt: submittedAt,
      );
}

extension NewRequestResponseModelMapper on NewRequestResponseModel {
  NewRequestResultEntity toEntity() => NewRequestResultEntity(
        message: message,
        request: data.toEntity(),
      );
}