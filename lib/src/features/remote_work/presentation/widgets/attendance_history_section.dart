part of '../imports/remote_work_imports.dart';

class _AttendanceHistorySection extends StatelessWidget {
  const _AttendanceHistorySection({
    required this.records,
    required this.controller,
    required this.isLoadingMore,
  });

  final List<AttendanceEntity> records;
  final RemoteWorkViewController controller;
  final bool isLoadingMore;

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
          Column(
            children: [
              for (final record in records) ...[
                _AttendanceCard(record: record, controller: controller),
                12.szH,
              ],
            ],
          ),
        if (isLoadingMore) ...[
          Center(
            child: SizedBox.square(
              dimension: AppSize.sH24,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          12.szH,
        ],
      ],
    );
  }
}
