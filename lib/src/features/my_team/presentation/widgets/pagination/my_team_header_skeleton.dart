part of '../../imports/my_team_imports.dart';

class _MyTeamHeaderSkeleton extends StatelessWidget {
  const _MyTeamHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Container(
          height: 20,

          width: 150,

          decoration: BoxDecoration(
            color: Colors.grey.shade300,

            borderRadius: BorderRadius.circular(6),
          ),
        ),

        Container(
          width: 25,

          height: 25,

          decoration: BoxDecoration(
            color: Colors.grey.shade300,

            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }
}
