part of '../imports/employees_imports.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          InkWell(
            onTap: () {
              Go.to(NotificationsScreen());
            },
            child: IconWidget(
              icon: Icons.notifications_none,
              color: AppColors.primary,
              height: AppSize.sH25,
            ).paddingSymmetric(horizontal: AppPadding.pH12),
          ),
        ],
      ),
      body: _EmployeesBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Go.to(AddEmployeeScreen());
        },
        backgroundColor: AppColors.primary,
        elevation: 4,
        child: Icon(Icons.add, color: Color(0xFF587300), size: 28),
      ),
    );
  }
}
