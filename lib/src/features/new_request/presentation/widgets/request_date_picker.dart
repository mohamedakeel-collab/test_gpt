part of '../imports/new_request_imports.dart';

class _RequestDatePicker extends StatelessWidget {
  const _RequestDatePicker({
    required this.isHourlyPermission,
  });

  final bool isHourlyPermission;

  @override
  Widget build(BuildContext context) {

    if (isHourlyPermission) {
      return const _SingleDateField();
    }

    return Row(
      children: [
        Expanded(
          child: _DateField(
            title: LocaleKeys.startDate,
          ),
        ),

        12.szW,

        Expanded(
          child: _DateField(
            title: LocaleKeys.endDate,
          ),
        ),


      ],
    );
  }
}
class _SingleDateField extends StatelessWidget {
  const _SingleDateField();

  @override
  Widget build(BuildContext context) {
    return _DateField(
      title: LocaleKeys.permissionDate,
    );
  }
}
class _DateField extends StatelessWidget {
  const _DateField({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle().setHintColor.s12.regular),

        6.szH,

        Container(
          height: AppSize.sH42,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r10),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            'mm/dd/yyyy',
            style: const TextStyle().setHintColor.s12.regular,
          ),
        ),
      ],
    );
  }
}
