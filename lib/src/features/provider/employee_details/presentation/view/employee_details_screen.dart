part of '../imports/employee_details_imports.dart';

class EmployeesDetailsScreen extends StatefulWidget {
  const EmployeesDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<EmployeesDetailsScreen> createState() => _EmployeesDetailsScreenState();
}

class _EmployeesDetailsScreenState extends State<EmployeesDetailsScreen> {
  late final EmployeeDetailsCubit _cubit;
  late final EmployeeDetailsViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<EmployeeDetailsCubit>()..getEmployeeDetails(widget.id);
    _controller = EmployeeDetailsViewController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeDetailsCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.employeeDetails,
          showArrow: true,
          onTap: Go.back,
        ),
        body: _EmployeeDetailsBody(
          controller: _controller,
          employeeId: widget.id,
        ),
      ),
    );
  }
}
