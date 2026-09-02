part of '../../imports/profile_imports.dart';

class _ProfileHeaderSkeleton extends StatelessWidget {
  const _ProfileHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        70.szH,


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


        8.szH,


        Container(
          height: 12,
          width: 90,

          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(6),
          ),
        ),

      ],
    );
  }
}