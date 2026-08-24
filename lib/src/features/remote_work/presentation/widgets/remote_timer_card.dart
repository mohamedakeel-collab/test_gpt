part of '../imports/remote_work_imports.dart';

class _RemoteTimerCard extends StatefulWidget {
  const _RemoteTimerCard({required this.record});

  final AttendanceEntity? record;

  @override
  State<_RemoteTimerCard> createState() => _RemoteTimerCardState();
}

class _RemoteTimerCardState extends State<_RemoteTimerCard> {
  Timer? _timer;
  static DateTime? _startedAt;

  static bool _isWorking = false;


  @override
  void initState() {
    super.initState();

    if (_isWorking) {
      _startTimer();
    }
  }


  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (!mounted) return;

        setState(() {});
      },
    );
  }


  void _startWork() {
    setState(() {
      _isWorking = true;
      _startedAt = DateTime.now();
    });

    _startTimer();
  }


  void _endWork() {
    _timer?.cancel();

    setState(() {
      _isWorking = false;
      _startedAt = null;
    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  String get elapsedText {

    if (!_isWorking || _startedAt == null) {
      return '00:00:00';
    }


    final elapsed =
    DateTime.now().difference(
      _startedAt!,
    );


    final hours =
    elapsed.inHours
        .toString()
        .padLeft(2, '0');


    final minutes =
    (elapsed.inMinutes % 60)
        .toString()
        .padLeft(2, '0');


    final seconds =
    (elapsed.inSeconds % 60)
        .toString()
        .padLeft(2, '0');


    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.record;

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
            record == null
                ? LocaleKeys.remoteWork
                : LocaleKeys.workingRemotelyNow,

            style: const TextStyle().setLabelColor.s12.medium,
          ),

          20.szH,

          Text(
            _isWorking ? elapsedText : '00:00:00',

            style: const TextStyle().setBrandSurfaceColor.s40.bold,
          ),
          20.szH,
          Center(
            child: LoadingButton(
              color: AppColors.primary,
              textColor: AppColors.splashBackground,

              title: _isWorking
                  ? LocaleKeys.endWork
                  : LocaleKeys.startWork,

              onTap: () async {

                if (_isWorking) {
                  _endWork();
                } else {
                  _startWork();
                }

              },
            ),
          ),
        ],
      ),
    );
  }
}
