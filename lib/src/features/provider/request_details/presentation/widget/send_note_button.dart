part of '../imports/request_details_imports.dart';

class SendNoteButton extends StatelessWidget {
  const SendNoteButton({
    super.key,
    required this.controller,
    required this.onSend,
    this.enabled = true,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Expanded(
          child: DefaultTextField(
            borderColor: AppColors.border,
            title: LocaleKeys.writeYourNote,
            action: TextInputAction.done,
            controller: controller,
            validator: (v) => Validators.validateEmpty(
              v,
              fieldTitle: LocaleKeys.writeYourNote,
            ),
          ),
        ),
        8.szW,

        GestureDetector(
          onTap: enabled ? onSend : null,

          child: Container(
            width: AppSize.sH40,

            height: AppSize.sH40,

            decoration: BoxDecoration(
              color: enabled ? AppColors.primary : AppColors.border,

              borderRadius: BorderRadius.circular(AppCircular.r10),
            ),

            child: Icon(
              Icons.send_outlined,

              color: AppColors.splashBackground,

              size: AppSize.sH20,
            ),
          ),
        ),
      ],
    ).paddingAll(AppPadding.pH16);
  }
}
