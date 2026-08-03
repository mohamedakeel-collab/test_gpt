part of '../imports/new_request_imports.dart';

class _RequestTimePicker extends StatelessWidget {
  const _RequestTimePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TimeField(
            title: LocaleKeys.fromTime,
            time: '08:00 AM',
          ),
        ),
        12.szW,
        Expanded(
          child: _TimeField(
            title: LocaleKeys.toTime,
            time: '10:00 AM',
          ),
        ),

      ],
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.title,
    required this.time,
  });

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle()
              .setHintColor
              .s12
              .regular,
        ),

        6.szH,

        Container(
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
                time,
                style: const TextStyle()
                    .setMainTextColor
                    .s13
                    .regular,
              ),

            ],
          ),
        ),
      ],
    );
  }
}