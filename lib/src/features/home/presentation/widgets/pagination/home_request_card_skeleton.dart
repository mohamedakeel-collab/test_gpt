part of '../../imports/home_imports.dart';

class _HomeRequestCardSkeleton extends StatelessWidget {
  const _HomeRequestCardSkeleton();

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
            children: [
              Container(
                width: 40,

                height: 40,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              12.szW,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      height: 14,

                      width: 130,

                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,

                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),

                    10.szH,

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

          16.szH,

          Container(
            height: 12,

            width: double.infinity,

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
