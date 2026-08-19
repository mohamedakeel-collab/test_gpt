import 'new_request_model.dart';

/// Wire model of the full `POST /leave-requests/store` envelope:
/// `{"message": "...", "data": {…}}`.
class NewRequestResponseModel {
  const NewRequestResponseModel({
    required this.message,
    required this.data,
  });

  factory NewRequestResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final dataMap = rawData is Map<String, dynamic>
        ? rawData
        : rawData is Map
            ? Map<String, dynamic>.from(rawData)
            : <String, dynamic>{};
    return NewRequestResponseModel(
      message: json['message']?.toString() ?? '',
      data: NewRequestModel.fromJson(dataMap),
    );
  }

  final String message;
  final NewRequestModel data;
}