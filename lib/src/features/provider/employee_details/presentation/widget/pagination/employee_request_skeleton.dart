part of '../../imports/employee_details_imports.dart';

class _EmployeeRequestSkeleton extends StatelessWidget {
  const _EmployeeRequestSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppPadding.pH16,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
        BorderRadius.circular(
          AppCircular.r12,
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                height: 16,
                width: 100,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),


              const Spacer(),


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


          12.szH,


          Container(
            height: 12,
            width: 160,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          ),


          12.szH,


          Container(
            height: 12,
            width: 80,

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