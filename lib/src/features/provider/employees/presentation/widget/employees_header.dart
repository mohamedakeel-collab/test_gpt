part of '../imports/employees_imports.dart';

class _EmployeesHeader extends StatelessWidget {
  const _EmployeesHeader({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(LocaleKeys.employees, style: const TextStyle().setMainTextColor.s20.bold),

        Text('$totalCount ${LocaleKeys.employee}', style: const TextStyle().setHintColor.s12.regular),
      ],
    );
  }
}
