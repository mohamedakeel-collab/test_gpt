part of '../imports/add_employee_imports.dart';

class _AddEmployeeButton extends StatelessWidget {

  const _AddEmployeeButton({
    required this.controller,
    required this.mode,
    this.employeeId,
  });


  final AddEmployeeViewController controller;
  final EmployeeMode mode;
  final int? employeeId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEmployeeCubit, AsyncState<EmployeeEntity>>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(AppPadding.pH16),
          color: AppColors.white,
          child: LoadingButton(
              title: mode == EmployeeMode.edit
                  ? LocaleKeys.updateEmployee
                  : LocaleKeys.createEmployee,
            color: AppColors.primary,
            textColor: AppColors.splashBackground,
            borderRadius: AppCircular.r12,
            isDisabled: state.isLoading,
              onTap: () async {

                if(!controller.validateForm()){
                  return;
                }


                final cubit =
                context.read<AddEmployeeCubit>();


                if(mode == EmployeeMode.edit){

                  await cubit.updateEmployee(
                    employeeId!,
                    controller.toParams(),
                  );

                }else{

                  await cubit.createEmployee(
                    controller.toParams(),
                  );

                }

              }
          ),
        );
      },
    );
  }
}
