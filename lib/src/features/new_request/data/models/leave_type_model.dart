class LeaveTypeModel {
  final int id;
  final String name;
  final String translatedName;

  LeaveTypeModel({
    required this.id,
    required this.name,
    required this.translatedName,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => LeaveTypeModel(
    id: int.tryParse(json['id'].toString()) ?? 0,
    name: json['name'] ?? '',
    translatedName: json['translated_name'] ?? '',
  );
}
