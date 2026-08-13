part of '../imports/remote_work_imports.dart';

class _RemoteWorkStatusCard extends StatelessWidget {
  const _RemoteWorkStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),

        border: Border.all(color: AppColors.border),
      ),

      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW12,
              vertical: AppPadding.pH6,
            ),

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.15),
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppCircular.r20),
            ),

            child: Text(
              LocaleKeys.workingRemotelyNow,

              style: const TextStyle().setLabelColor.s12.medium,
            ),
          ),

          20.szH,

          const _RemoteTimerCard(),

          20.szH,

          LoadingButton(
            title: LocaleKeys.endWork,

            color: AppColors.splashBackground,

            textColor: AppColors.white,

            borderRadius: AppCircular.r20,

            borderSide: BorderSide(color: AppColors.border),

            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
