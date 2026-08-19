part of '../imports/new_request_imports.dart';

class _RequestReasonField extends StatelessWidget {
  const _RequestReasonField({
    this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.requestReason,
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),

        8.szH,

        DefaultTextField(
          controller: controller,
          title: LocaleKeys.writeReason,
          inputType: TextInputType.multiline,
          maxLines: 5,
          contentPadding: EdgeInsets.all(AppPadding.pH16),
          borderRadius: BorderRadius.circular(AppCircular.r10),
          fillColor: AppColors.white,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}