part of '../../imports/remote_work_imports.dart';

class _RemoteTimerSkeleton extends StatelessWidget {
  const _RemoteTimerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Column(
        children: [
          Container(
            height: 14,

            width: 130,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(6),
            ),
          ),

          20.szH,

          Container(
            height: 45,

            width: 180,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(8),
            ),
          ),

          20.szH,

          Container(
            height: 45,

            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
