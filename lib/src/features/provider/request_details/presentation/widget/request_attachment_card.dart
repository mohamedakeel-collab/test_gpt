part of '../imports/request_details_imports.dart';

class RequestAttachmentCard extends StatelessWidget {
  const RequestAttachmentCard({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pH16,
          vertical: AppPadding.pH12,
        ),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.circular(AppCircular.r12),

          border: Border.all(color: AppColors.border),
        ),

        child: Row(
          children: [
            IconWidget(
              icon: AppAssets.svg.baseSvg.attachment.path,
              height: AppSize.sH22,
            ),

            8.szW,

            Text(
              'مرفق التقرير',

              style: const TextStyle().setMainTextColor.s14.medium,
            ),

            const Spacer(),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppSize.sH16,
              color: AppColors.border,
            ),
          ],
        ),
      ),
    );
  }
}
