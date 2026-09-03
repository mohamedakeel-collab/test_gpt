part of '../../imports/order_details_imports.dart';

class _RequestAttachmentSkeleton extends StatelessWidget {
  const _RequestAttachmentSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,

      padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Row(
        children: [
          Container(width: 22, height: 22, color: Colors.grey.shade300),

          12.szW,

          Container(
            width: 120,
            height: 14,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
}
