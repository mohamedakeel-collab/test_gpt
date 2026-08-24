part of '../imports/remote_work_imports.dart';

class _RemoteWorkBody extends StatelessWidget {
  const _RemoteWorkBody({required this.controller});

  final RemoteWorkViewController controller;

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<AttendanceCubit, List<AttendanceEntity>>(
      onRetry: () => context.read<AttendanceCubit>().getAttendance(),
      builder: (context, records) {
        return RefreshIndicator(
          onRefresh: () => context.read<AttendanceCubit>().getAttendance(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.szH,
                _RemoteTimerCard(record: controller.activeRecord(records)),
                20.szH,
                _AttendanceHistorySection(
                  records: records,
                  controller: controller,
                ),
              ],
            ).paddingSymmetric(horizontal: AppPadding.pH16),
          ),
        );
      },
    );
  }
}
