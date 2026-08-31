part of '../imports/employee_details_imports.dart';

class EmployeesDetailsScreen extends StatelessWidget {
  const EmployeesDetailsScreen({super.key, required this.employee});

  final EmployeeEntity employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(   title: LocaleKeys.newRequestTitle,
        showArrow: true,onTap: (){
          Go.back();
        },),
      body: _EmployeeDetailsBody(employee: employee),

    );
  }
}
