part of '../../imports/request_details_imports.dart';

class _RequestBalanceSkeleton extends StatelessWidget {
  const _RequestBalanceSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(
          AppCircular.r12,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        children: [

          _row(),

          Divider(
            color: AppColors.border,
          ),

          _row(),

        ],
      ),
    );
  }


  Widget _row(){

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),

      child: Row(
        children: [

          Container(
            width: 20,
            height: 20,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),


          8.szW,


          Container(
            width: 100,
            height: 12,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          ),


          const Spacer(),


          Container(
            width: 50,
            height: 16,

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