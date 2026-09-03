part of '../../imports/my_team_imports.dart';

class _TeamRequestCardSkeleton extends StatelessWidget {
  const _TeamRequestCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                width: AppSize.sH40,

                height: AppSize.sH40,

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

                      width: 140,

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

              8.szW,

              Container(
                height: 24,

                width: 75,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),

          16.szH,

          Container(height: 1, color: Colors.grey.shade200),

          16.szH,

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 12,

                  width: 100,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),

              16.szW,

              Expanded(
                child: Container(
                  height: 12,

                  width: 120,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
