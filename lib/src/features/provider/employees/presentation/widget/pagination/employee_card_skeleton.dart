part of '../../imports/employees_imports.dart';

class _EmployeeCardSkeleton extends StatelessWidget {
  const _EmployeeCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),

      child: Row(
        children: [

          Container(
            width: AppSize.sW60,
            height: AppSize.sH60,

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
                  width: 150,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),


                10.szH,


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


          10.szW,


          Container(
            width: 70,
            height: 22,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

        ],
      ),
    );
  }
}