part of '../../imports/employee_details_imports.dart';

class _EmployeeDetailsHeaderSkeleton extends StatelessWidget {
  const _EmployeeDetailsHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.splashBackground,

        borderRadius: BorderRadius.circular(
          AppCircular.r15,
        ),
      ),

      child: Column(
        children: [

          Container(
            width: AppSize.sW90,
            height: AppSize.sW90,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),


          12.szH,


          Container(
            height: 18,
            width: 140,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          ),


          10.szH,


          Container(
            height: 12,
            width: 120,

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


          16.szH,


          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Container(
                width: 80,
                height: 35,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),


              12.szW,


              Container(
                width: 80,
                height: 35,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}