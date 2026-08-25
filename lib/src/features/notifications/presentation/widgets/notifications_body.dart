part of '../imports/notifications_imports.dart';

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody({required this.controller});

  final NotificationsViewController controller;

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<NotificationsCubit, List<NotificationEntity>>(
      onRetry: () => context.read<NotificationsCubit>().getNotifications(),
      builder: (context, notifications) {
        return RefreshIndicator(
          onRefresh: () =>
              context.read<NotificationsCubit>().getNotifications(),
          child: notifications.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.pH16,
                    vertical: AppPadding.pH8,
                  ),
                  children: [
                    120.szH,
                    EmptyWidget(
                      title: LocaleKeys.noNotifications,
                      desc: LocaleKeys.errorexceptionNotcontaindesc,
                    ),
                  ],
                )
              : ListView.separated(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.pH16,
                    vertical: AppPadding.pH8,
                  ),
                  itemCount: notifications.length,
                  separatorBuilder: (_, _) => 12.szH,
                  itemBuilder: (_, i) {
                    return _NotificationCard(
                      notification: notifications[i],
                      controller: controller,
                    );
                  },
                ),
        );
      },
    );
  }
}
