part of '../../imports/request_details_imports.dart';

class _RequestSmallCardSkeleton extends StatelessWidget {
  const _RequestSmallCardSkeleton();

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 55,

      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
        BorderRadius.circular(
          AppCircular.r12,
        ),

        border:
        Border.all(
          color: AppColors.border,
        ),
      ),


      child: Row(
        children: [

          Container(
            width: 22,
            height: 22,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),


          10.szW,


          Container(
            width: 100,
            height: 13,

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