part of '../imports/add_employee_imports.dart';

class _AddEmployeeBody extends StatelessWidget {
  const _AddEmployeeBody({required this.controller});

  final AddEmployeeViewController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.szH,
          _EmployeeImagePicker(
            image: controller.employeeImage,

            onPick: () async {
              await controller.pickEmployeeImage();
            },
          ),
          24.szH,
          _EmployeeFormSection(controller: controller),
          24.szH,
          _LoginDataSection(controller: controller),
          100.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
