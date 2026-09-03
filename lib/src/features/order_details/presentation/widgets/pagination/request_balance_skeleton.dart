part of '../../imports/order_details_imports.dart';

class _RequestBalanceSkeleton extends StatelessWidget {
  const _RequestBalanceSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Column(
        children: [
          _row(),

          Divider(color: AppColors.border),

          _row(),
        ],
      ),
    );
  }

  Widget _row() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          10.szW,

          Container(
            height: 13,
            width: 120,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          const Spacer(),

          Container(
            height: 15,
            width: 60,

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
