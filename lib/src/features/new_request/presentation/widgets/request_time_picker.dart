part of '../imports/new_request_imports.dart';

class _RequestTimePicker extends StatelessWidget {
  const _RequestTimePicker({
    this.fromTime,
    this.toTime,
    this.onFromChanged,
    this.onToChanged,
  });

  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final ValueChanged<TimeOfDay?>? onFromChanged;
  final ValueChanged<TimeOfDay?>? onToChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TimeField(
            title: LocaleKeys.fromTime,
            time: fromTime,
            onChanged: onFromChanged,
          ),
        ),
        12.szW,
        Expanded(
          child: _TimeField(
            title: LocaleKeys.toTime,
            time: toTime,
            onChanged: onToChanged,
          ),
        ),
      ],
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.title,
    this.time,
    this.onChanged,
  });

  final String title;
  final TimeOfDay? time;
  final ValueChanged<TimeOfDay?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle().setHintColor.s12.regular,
        ),

        6.szH,

        GestureDetector(
          onTap: () => _pickTime(context),
          child: Container(
            height: AppSize.sH42,
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW12,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppCircular.r10,
              ),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: Row(
              children: [
                IconWidget(
                  icon: Icons.watch_later_outlined,
                  color: AppColors.black,
                  height: AppSize.sH18,
                ),

                const Spacer(),

                Text(
                  time?.format(context) ?? '08:00 AM',
                  style: time == null
                      ? const TextStyle().setHintColor.s13.regular
                      : const TextStyle().setMainTextColor.s13.regular,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showCustomTimePicker(
      initialTime: time,
    );

    if (picked != null) {
      onChanged?.call(picked);
    }
  }
}