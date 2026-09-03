part of '../../imports/home_imports.dart';

class _BalanceCardSkeleton extends StatelessWidget {
  const _BalanceCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH18),

      margin: EdgeInsets.only(bottom: AppPadding.pH18, top: AppPadding.pH4),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),

      child: Row(
        children: [
          Container(
            width: AppSize.sH90,

            height: AppSize.sH90,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              shape: BoxShape.circle,
            ),
          ),

          30.szW,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 18,

                  width: 120,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                12.szH,

                Container(
                  height: 32,

                  width: 70,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                10.szH,

                Container(
                  height: 14,

                  width: 150,

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
    ).paddingSymmetric(horizontal: AppPadding.pH16);
  }
}
