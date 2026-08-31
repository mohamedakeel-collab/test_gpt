part of '../imports/add_employee_imports.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  late final DepartmentsCubit _cubit;
  late final DepartmentManagersCubit _managersCubit;
  late final AddEmployeeViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = injector<DepartmentsCubit>()..getDepartments();
    _managersCubit = injector<DepartmentManagersCubit>();
    _controller = AddEmployeeViewController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _managersCubit.close();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DepartmentsCubit>.value(value: _cubit),
        BlocProvider<DepartmentManagersCubit>.value(value: _managersCubit),
        BlocProvider<AddEmployeeCubit>(
          create: (_) => injector<AddEmployeeCubit>(),
        ),
      ],
      child: BlocListener<AddEmployeeCubit, AsyncState<EmployeeEntity>>(
        listener: (context, state) {
          switch (state) {
            case AsyncSuccess<EmployeeEntity>():
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.success,
                message: LocaleKeys.employeeCreatedSuccessfully,
              );
              Go.back(true);
              break;
            case AsyncFailure<EmployeeEntity>(:final failure):
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.error,
                message: failure.userMessage.isNotEmpty
                    ? failure.userMessage
                    : LocaleKeys.employeeCreationFailed,
              );
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: LocaleKeys.addEmployee,
            showArrow: true,
            onTap: () {
              Go.back();
            },
          ),
          body: Form(
            key: _controller.formKey,
            child: _AddEmployeeBody(controller: _controller),
          ),
          bottomNavigationBar: _AddEmployeeButton(controller: _controller),
        ),
      ),
    );
  }
}
