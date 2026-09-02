part of '../../imports/profile_imports.dart';

class _ProfileMenuSkeleton extends StatelessWidget {
  const _ProfileMenuSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,

      child: Row(
        children: [

          Container(
            width: AppSize.sH22,
            height: AppSize.sH22,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),


          15.szW,


          Container(
            height: 14,
            width: 100,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius:
              BorderRadius.circular(6),
            ),
          ),


          const Spacer(),


          Container(
            height: 14,
            width: 14,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius:
              BorderRadius.circular(4),
            ),
          ),

        ],
      ),
    );
  }
}