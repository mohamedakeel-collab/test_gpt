part of '../../imports/profile_imports.dart';

class _ProfileInfoSkeleton extends StatelessWidget {
  const _ProfileInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppPadding.pH12,
      ),

      decoration: BoxDecoration(
        color: AppColors.fill,

        borderRadius:
        BorderRadius.circular(
          AppCircular.r10,
        ),
      ),

      child: Row(
        children: [

          Container(
            width: AppSize.sH35,
            height: AppSize.sH35,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              shape: BoxShape.circle,
            ),
          ),


          12.szW,


          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Container(
                height: 12,
                width: 70,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                  BorderRadius.circular(6),
                ),
              ),


              8.szH,


              Container(
                height: 13,
                width: 120,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                  BorderRadius.circular(6),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}