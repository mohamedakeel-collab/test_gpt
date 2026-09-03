part of '../../imports/home_imports.dart';

class _RecentRequestsSkeleton extends StatelessWidget {
  const _RecentRequestsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          height: 20,

          width: 160,

          decoration: BoxDecoration(
            color: Colors.grey.shade300,

            borderRadius: BorderRadius.circular(6),
          ),
        ),

        16.szH,

        ...List.generate(
          3,

          (_) => Padding(
            padding: EdgeInsets.only(bottom: AppPadding.pH12),

            child: const _HomeRequestCardSkeleton(),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: AppPadding.pH16);
  }
}
