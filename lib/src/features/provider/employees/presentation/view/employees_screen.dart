part of '../imports/employees_imports.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late final EmployeesCubit _cubit;
  late final EmployeesViewController _controller;

  @override
  void initState() {
    super.initState();

    _cubit = injector<EmployeesCubit>()..getEmployees(perPage: 15);

    _controller = EmployeesViewController(
      onSearchChangedApi: (search) {
        _cubit.getEmployees(perPage: 15, search: search);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeesCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.employees,
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
        body: _EmployeesBody(controller: _controller),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Go.to(AddEmployeeScreen());
          },
          backgroundColor: AppColors.primary,
          elevation: 4,
          child: IconWidget(
            icon: Icons.add,
            color: const Color(0xFF587300),
            height: AppSize.sH28,
          ),
        ),
      ),
    );
  }
}
