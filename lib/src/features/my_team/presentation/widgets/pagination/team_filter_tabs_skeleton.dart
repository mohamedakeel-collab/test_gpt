part of '../../imports/my_team_imports.dart';

class _TeamFilterTabsSkeleton extends StatelessWidget {
  const _TeamFilterTabsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == 2 ? 0 : 8),

            height: 36,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(AppCircular.r20),
            ),
          ),
        );
      }),
    );
  }
}
