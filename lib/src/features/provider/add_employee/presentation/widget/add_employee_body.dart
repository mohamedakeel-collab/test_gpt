part of '../imports/add_employee_imports.dart';

class _AddEmployeeBody extends StatelessWidget {
  const _AddEmployeeBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          20.szH,

          const _EmployeeImagePicker(),

          24.szH,

          const _EmployeeFormSection(),

          24.szH,

          const _LoginDataSection(),

          100.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
