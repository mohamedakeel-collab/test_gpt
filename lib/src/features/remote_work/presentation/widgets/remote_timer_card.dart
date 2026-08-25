part of '../imports/remote_work_imports.dart';

class _RemoteTimerCard extends StatefulWidget {
  const _RemoteTimerCard({required this.record, required this.controller});

  final AttendanceEntity? record;

  final RemoteWorkViewController controller;

  @override
  State<_RemoteTimerCard> createState() => _RemoteTimerCardState();
}

class _RemoteTimerCardState extends State<_RemoteTimerCard> {
  Timer? _timer;

  bool get isWorking => widget.controller.startedAt != null;

  @override
  void initState() {
    super.initState();

    _loadStartTime();
  }

  Future<void> _loadStartTime() async {
    await widget.controller.init();

    if (widget.controller.startedAt != null) {
      _startTimer();

      setState(() {});
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {});
    });
  }

  Future<void> _startWork() async {
    final cubit = context.read<AttendanceCubit>();

    final result = await cubit.checkIn();

    result.fold((failure) {}, (_) async {
      final now = DateTime.now();

      await RemoteWorkStorage.saveStartTime(now);

      widget.controller.setStartTime(now);

      _startTimer();

      setState(() {});
    });
  }

  Future<void> _endWork() async {
    final cubit = context.read<AttendanceCubit>();

    final result = await cubit.checkOut();

    result.fold((failure) {}, (_) async {
      await RemoteWorkStorage.clearStartTime();

      widget.controller.clearStartTime();

      _timer?.cancel();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Column(
        children: [
          Text(
            isWorking ? LocaleKeys.workingRemotelyNow : LocaleKeys.remoteWork,

            style: const TextStyle().setLabelColor.s12.medium,
          ),

          20.szH,

          Text(
            widget.controller.elapsedLabel(),

            style: const TextStyle().setBrandSurfaceColor.s40.bold,
          ),

          20.szH,

          LoadingButton(
            color: AppColors.primary,

            textColor: AppColors.splashBackground,

            title: isWorking ? LocaleKeys.endWork : LocaleKeys.startWork,

            onTap: () async {
              if (isWorking) {
                await _endWork();
              } else {
                await _startWork();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}
