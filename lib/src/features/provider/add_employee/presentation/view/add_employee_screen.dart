part of '../imports/add_employee_imports.dart';

enum EmployeeMode { add, edit }

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({
    super.key,
    this.employee,
    this.mode = EmployeeMode.add,
  });

  final EmployeeDetailsEntity? employee;
  final EmployeeMode mode;

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

    _controller = AddEmployeeViewController(
      isEdit: widget.mode == EmployeeMode.edit,
    );

    if (widget.mode == EmployeeMode.edit && widget.employee != null) {
      _controller.prefillEmployee(widget.employee!);
    }
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
    final isEdit = widget.mode == EmployeeMode.edit;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),

        BlocProvider.value(value: _managersCubit),

        BlocProvider(create: (_) => injector<AddEmployeeCubit>()),
      ],

      child: BlocListener<AddEmployeeCubit, AsyncState<EmployeeEntity>>(
        listener: (context, state) {
          switch (state) {
            case AsyncSuccess<EmployeeEntity>():
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.success,
                message: isEdit
                    ? LocaleKeys.employeeUpdatedSuccessfully
                    : LocaleKeys.employeeCreatedSuccessfully,
              );

              Go.back(true);

              break;

            case AsyncFailure<EmployeeEntity>(:final failure):
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.error,
                message: failure.userMessage,
              );

              break;

            default:
              break;
          }
        },

        child: Scaffold(
          backgroundColor: AppColors.white,

          appBar: CustomAppBar(
            title: isEdit ? LocaleKeys.updateEmployee : LocaleKeys.addEmployee,

            showArrow: true,

            onTap: Go.back,
          ),

          body: Form(
            key: _controller.formKey,

            child: _AddEmployeeBody(controller: _controller),
          ),

          bottomNavigationBar: _AddEmployeeButton(
            controller: _controller,
            mode: widget.mode,
            employeeId: widget.employee?.id,
          ),
        ),
      ),
    );
  }
}
