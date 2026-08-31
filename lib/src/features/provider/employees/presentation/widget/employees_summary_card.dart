part of '../imports/employees_imports.dart';

class _EmployeesSummaryCard extends StatelessWidget {
  const _EmployeesSummaryCard({
    required this.totalCount,
    required this.pendingCount,
  });

  final int totalCount;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH100,

      padding: EdgeInsets.all(
        AppPadding.pH16,
      ),

      decoration: BoxDecoration(
        color: AppColors.splashBackground,
        borderRadius: BorderRadius.circular(
          AppCircular.r20,
        ),
        border: Border(
          right: BorderSide(
            color: AppColors.primary,
            width: 8,
          ),
        ),
      ),

      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [

              Text(LocaleKeys.pendingRequest, style: const TextStyle().setPrimaryColor.s20.bold),

              12.szH,

              Text('$pendingCount ${LocaleKeys.employee}', style: const TextStyle().setWhiteColor.s16.medium),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(LocaleKeys.employees, style: const TextStyle().setPrimaryColor.s12.medium),
              4.szH,
              Text('$totalCount', style: const TextStyle().setWhiteColor.s20.bold),
            ],
          ),
          12.szW,
          Container(
            width: AppSize.sW70,
            height: AppSize.sH70,

            decoration: BoxDecoration(
              color: AppColors.warningSurface,
              shape: BoxShape.circle,
            ),

            child: IconWidget(
              icon: Icons.pending_actions_outlined,
              color: AppColors.warning,
              height: AppSize.sH40,
            ),
          ),

        ],
      ),
    );
  }
}
