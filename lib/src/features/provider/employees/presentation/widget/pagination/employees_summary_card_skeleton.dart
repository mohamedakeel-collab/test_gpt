part of '../../imports/employees_imports.dart';

class _EmployeesSummaryCardSkeleton extends StatelessWidget {
  const _EmployeesSummaryCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH100,

      padding: EdgeInsets.all(
        AppPadding.pH16,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(
          AppCircular.r20,
        ),

        border: Border(
          right: BorderSide(
            color: AppColors.border,
            width: 8,
          ),
        ),
      ),


      child: Row(
        children: [

          Expanded(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Container(
                  height: 20,
                  width: 120,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),


                12.szH,


                Container(
                  height: 16,
                  width: 90,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),

              ],
            ),
          ),



          Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Container(
                height: 12,
                width: 60,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius:
                  BorderRadius.circular(6),
                ),
              ),


              8.szH,


              Container(
                height: 22,
                width: 40,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius:
                  BorderRadius.circular(6),
                ),
              ),

            ],
          ),



          12.szW,



          Container(
            width: AppSize.sW70,

            height: AppSize.sH70,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              shape: BoxShape.circle,
            ),
          ),

        ],
      ),
    );
  }
}
