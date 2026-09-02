part of '../../imports/request_details_imports.dart';

class _RequestInfoSkeleton extends StatelessWidget {
  const _RequestInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(
          AppCircular.r12,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Expanded(
                child: _box(),
              ),

              12.szW,

              Expanded(
                child: _box(),
              ),

            ],
          ),


          16.szH,


          Container(
            height: 90,
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius:
              BorderRadius.circular(10),
            ),
          ),


          16.szH,


          _box(
            width: double.infinity,
          ),

        ],
      ),
    );
  }


  Widget _box({
    double width = 100,
  }){

    return Container(
      height: 14,
      width: width,

      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius:
        BorderRadius.circular(6),
      ),
    );

  }
}