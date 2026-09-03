part of '../../imports/order_details_imports.dart';

class _RequestNotesSkeleton extends StatelessWidget {
  const _RequestNotesSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,

      padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r20),

        border: Border.all(color: AppColors.border),
      ),

      child: Row(
        children: [
          Container(width: 24, height: 24, color: Colors.grey.shade300),

          12.szW,

          Container(
            width: 80,
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
