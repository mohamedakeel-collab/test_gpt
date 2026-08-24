part of '../imports/remote_work_imports.dart';

class _AttendanceHistorySection extends StatelessWidget {
  const _AttendanceHistorySection({
    required this.records,
    required this.controller,
  });

  final List<AttendanceEntity> records;
  final RemoteWorkViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.attendanceHistory,
          style: const TextStyle().setMainTextColor.s16.bold,
        ),
        12.szH,
        if (records.isEmpty)
          EmptyWidget(
            title: LocaleKeys.noAttendanceRecords,
            desc: LocaleKeys.errorexceptionNotcontaindesc,
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: records.length,
            separatorBuilder: (_, _) => 12.szH,
            itemBuilder: (_, index) =>
                _AttendanceCard(record: records[index], controller: controller),
          ),
        12.szH,
      ],
    );
  }
}
