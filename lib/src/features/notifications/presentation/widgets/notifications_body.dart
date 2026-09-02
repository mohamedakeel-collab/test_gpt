part of '../imports/notifications_imports.dart';

class _NotificationsBody extends StatefulWidget {
  const _NotificationsBody({required this.controller});

  final NotificationsViewController controller;

  @override
  State<_NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<_NotificationsBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 100) {
      context.read<NotificationsCubit>().loadMore();
    }
  }

  Future<void> _refresh() {
    return context.read<NotificationsCubit>().getNotifications(perPage: 20);
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<NotificationsCubit, List<NotificationEntity>>(
      onRetry: _refresh,

      loadingBuilder: (_) {
        return ListView.separated(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: AppPadding.pH16,
            vertical: AppPadding.pH8,
          ),

          itemCount: 6,

          separatorBuilder: (_, _) => 12.szH,

          itemBuilder: (_, index) {
            return const _NotificationCardSkeleton();
          },
        );
      },

      builder: (context, notifications) {
        final cubit = context.read<NotificationsCubit>();

        final isLoadingMore = cubit.isLoadingMore;
        if (notifications.isEmpty) {
          return RefreshIndicator(
            onRefresh: _refresh,

            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),

              padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),

              children: [
                SizedBox(height: AppSize.sH120),

                EmptyWidget(
                  title: LocaleKeys.notificationsEmpty,

                  desc: LocaleKeys.errorexceptionNotcontaindesc,
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: _refresh,

          child: ListView.separated(
            controller: _scrollController,

            physics: const AlwaysScrollableScrollPhysics(),

            padding: EdgeInsetsDirectional.symmetric(
              horizontal: AppPadding.pH16,

              vertical: AppPadding.pH8,
            ),

            itemCount: notifications.length + (isLoadingMore ? 1 : 0),

            separatorBuilder: (_, _) => 12.szH,

            itemBuilder: (_, index) {
              if (index == notifications.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),

                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return _NotificationCard(
                notification: notifications[index],

                controller: widget.controller,
              );
            },
          ),
        );
      },
    );
  }
}
