part of '../../imports/remote_work_imports.dart';

class _AttendanceCardSkeleton extends StatelessWidget {
  const _AttendanceCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: AppSize.sW45,

            height: AppSize.sH45,

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
                  height: 14,

                  width: 100,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                8.szH,

                Container(
                  height: 12,

                  width: 130,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                8.szH,

                Container(
                  height: 12,

                  width: 90,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),

          12.szW,

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Container(
                height: 18,

                width: 55,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              12.szH,

              Container(
                height: 22,

                width: 70,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
