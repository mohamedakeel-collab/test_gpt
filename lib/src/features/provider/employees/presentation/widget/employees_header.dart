part of '../imports/employees_imports.dart';

class _EmployeesHeader extends StatelessWidget {
  const _EmployeesHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text('كل الموظفين', style: const TextStyle().setMainTextColor.s20.bold),

        Text(
          '٢٤ موظف إجمالي',
          style: const TextStyle().setHintColor.s12.regular,
        ),
      ],
    );
  }
}
