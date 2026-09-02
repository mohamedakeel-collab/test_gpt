part of '../../imports/profile_imports.dart';

class _ProfileBalanceSkeleton extends StatelessWidget {
  const _ProfileBalanceSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH90,

      padding: EdgeInsets.all(
        AppPadding.pH12,
      ),

      decoration: BoxDecoration(
        color: AppColors.splashBackground,

        borderRadius:
        BorderRadius.circular(
          AppCircular.r12,
        ),
      ),


      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Container(
            height: 12,
            width: 80,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius:
              BorderRadius.circular(6),
            ),
          ),


          12.szH,


          Container(
            height: 22,
            width: 60,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius:
              BorderRadius.circular(6),
            ),
          ),

        ],
      ),
    );
  }
}