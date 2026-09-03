part of '../imports/order_details_imports.dart';

class RequestBalanceCard extends StatelessWidget {
  const RequestBalanceCard({super.key, required this.employee});

  final EmployeeDetailsEntity employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _BalanceRow(
            icon: AppAssets.svg.baseSvg.vacationBalance.path,
            title: LocaleKeys.vacationBalance,
            value: '${employee.remainingLeaveBalance} ${LocaleKeys.day}',
          ),
          Divider(color: AppColors.border),
          _BalanceRow(
            icon: AppAssets.svg.baseSvg.permission.path,
            title: LocaleKeys.permissions,
            value: '${employee.permissionHours} ${LocaleKeys.hour}',
          ),
        ],
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  const _BalanceRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final String icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconWidget(icon: icon, height: AppSize.sH20),
        8.szW,
        Expanded(
          child: Text(title, style: const TextStyle().setHintColor.s13.regular),
        ),
        Text(value, style: const TextStyle().setMainTextColor.s16.bold),
      ],
    );
  }
}
