import 'package:equatable/equatable.dart';

class AttendanceRecordEntity extends Equatable {
  const AttendanceRecordEntity({
    required this.id,
    required this.date,
    required this.checkIn,
    required this.checkOut,
  });

  final int id;
  final String date;
  final String checkIn;
  final String checkOut;

  factory AttendanceRecordEntity.initial() =>
      const AttendanceRecordEntity(id: 0, date: '', checkIn: '', checkOut: '');

  @override
  List<Object?> get props => [id, date, checkIn, checkOut];
}
