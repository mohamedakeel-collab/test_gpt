part of '../imports/new_request_imports.dart';

class _RequestTypeSelector extends StatelessWidget {
  const _RequestTypeSelector();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.requestType,
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),

        8.szH,

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _TypeButton(title: LocaleKeys.sickLeave, active: false),

            8.szW,

            _TypeButton(title: LocaleKeys.annualLeave, active: true),
          ],
        ),
      ],
    );
  }
}

class _TypeButton extends StatelessWidget {
  const _TypeButton({required this.title, required this.active});

  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW18,
        vertical: AppPadding.pH8,
      ),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r10),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        title,
        style: active
            ? const TextStyle().setBlackColor.s14.medium
            : const TextStyle().setMainTextColor.s14.medium,
      ),
    );
  }
}
