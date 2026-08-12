part of '../imports/add_employee_imports.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppBar(
        title: LocaleKeys.addEmployee,
        showArrow: true,
        onTap: () {
          Go.back();
        },
      ),

      body: const _AddEmployeeBody(),

      bottomNavigationBar: const _AddEmployeeButton(),
    );
  }
}
