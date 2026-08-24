import '../../../../core/shared/extensions/json_extensions.dart';

class AttendanceRecordModel {
  const AttendanceRecordModel({
    required this.id,
    required this.date,
    required this.checkIn,
    required this.checkOut,
  });

  final int id;
  final String date;
  final String checkIn;
  final String checkOut;

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) =>
      AttendanceRecordModel(
        id: json.getInt('id'),
        date: json.getString('date'),
        checkIn: json.getString('check_in'),
        checkOut: json.getString('check_out'),
      );
}
