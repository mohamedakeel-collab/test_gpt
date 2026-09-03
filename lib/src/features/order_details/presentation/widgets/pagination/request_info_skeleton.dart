part of '../../imports/order_details_imports.dart';

class _RequestInfoSkeleton extends StatelessWidget {
  const _RequestInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _line()),

              12.szW,

              Expanded(child: _line()),
            ],
          ),

          16.szH,

          Container(
            height: 100,

            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(10),
            ),
          ),

          16.szH,

          _line(width: double.infinity),

          12.szH,

          _line(width: 200),
        ],
      ),
    );
  }

  Widget _line({double width = 100}) {
    return Container(
      height: 14,

      width: width,

      decoration: BoxDecoration(
        color: Colors.grey.shade300,

        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
