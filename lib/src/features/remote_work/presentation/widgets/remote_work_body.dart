part of '../imports/remote_work_imports.dart';

class _RemoteWorkBody extends StatefulWidget {
  const _RemoteWorkBody({required this.controller});

  final RemoteWorkViewController controller;

  @override
  State<_RemoteWorkBody> createState() => _RemoteWorkBodyState();
}

class _RemoteWorkBodyState extends State<_RemoteWorkBody> {
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
      context.read<AttendanceCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<AttendanceCubit, List<AttendanceEntity>>(
      onRetry: () => context.read<AttendanceCubit>().getAttendance(perPage: 15),
      builder: (context, records) {
        final cubit = context.read<AttendanceCubit>();
        return RefreshIndicator(
          onRefresh: () => context.read<AttendanceCubit>().getAttendance(perPage: 15),
          child: ListView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),
            children: [
              16.szH,
              _RemoteTimerCard(
                record: widget.controller.activeRecord(records),
                controller: widget.controller,
              ),
              20.szH,
              _AttendanceHistorySection(
                records: records,
                controller: widget.controller,
                isLoadingMore: cubit.isLoadingMore,
              ),
            ],
          ),
        );
      },
    );
  }
}
