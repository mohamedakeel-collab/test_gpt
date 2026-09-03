part of '../../imports/order_details_imports.dart';

class _RequestEmployeeSkeleton extends StatelessWidget {
  const _RequestEmployeeSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.splashBackground,

        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),

      child: Row(
        children: [
          Container(
            width: AppSize.sW55,
            height: AppSize.sW55,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),

          12.szW,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 15,
                  width: 130,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                8.szH,

                Container(
                  height: 12,
                  width: 100,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
