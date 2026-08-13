part of '../imports/remote_work_imports.dart';

class _RemoteWorkBody extends StatelessWidget {
  const _RemoteWorkBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          16.szH,

          const _RemoteWorkStatusCard(),

          20.szH,

          Text(
            LocaleKeys.remoteWorkHistory,

            style: const TextStyle().setMainTextColor.s16.bold,
          ),

          12.szH,

          const _RemoteHistoryCard(
            date: 'الأمس، 14 أكتوبر',
            time: '09:00 ص - 05:00 م',
            duration: '8س',
          ),

          12.szH,

          const _RemoteHistoryCard(
            date: 'الأحد، 12 أكتوبر',
            time: '09:15 ص - 05:30 م',
            duration: '8س 15د',
          ),
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
