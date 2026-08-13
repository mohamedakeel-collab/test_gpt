part of '../imports/remote_work_imports.dart';

class _RemoteTimerCard extends StatelessWidget {
  const _RemoteTimerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW260,
      height: AppSize.sH260,

      padding: EdgeInsets.all(AppPadding.pH8),

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(color: AppColors.border, width: 6),
      ),

      child: Container(
        padding: EdgeInsets.all(AppPadding.pH6),

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          border: Border.all(color: AppColors.primary, width: 3),
        ),

        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: AppColors.splashBackground,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                Icons.laptop_mac,

                color: AppColors.primary,

                size: AppSize.sH45,
              ),

              12.szH,

              Text(
                '02:35:19',

                style: const TextStyle().setPrimaryColor.s40.bold,
              ),

              8.szH,

              Text(
                'وقت البدء: 09:00 ص',

                style: const TextStyle().setWhiteColor.s16.regular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
