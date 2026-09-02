part of '../../imports/employee_details_imports.dart';

class _EmployeeBalanceSkeleton extends StatelessWidget {
  const _EmployeeBalanceSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH90,

      padding: EdgeInsets.all(
        AppPadding.pH12,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
        BorderRadius.circular(
          AppCircular.r12,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Container(
            height: 12,
            width: 70,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          ),


          12.szH,


          Container(
            height: 20,
            width: 45,

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