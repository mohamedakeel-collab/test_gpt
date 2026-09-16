class LeaveTypeEntity {
  final int id;
  final String name;
  final String translatedName;

  const LeaveTypeEntity({
    required this.id,
    required this.name,
    required this.translatedName,
  });

  factory LeaveTypeEntity.initial() =>
      const LeaveTypeEntity(id: 0, name: '', translatedName: '');
}
