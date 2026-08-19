import 'new_request_entity.dart';

/// Result of submitting a new leave request — the API envelope
/// `{"message": "...", "data": {…}}` mapped to domain types.
class NewRequestResultEntity {
  const NewRequestResultEntity({
    required this.message,
    required this.request,
  });

  final String message;
  final NewRequestEntity request;
}