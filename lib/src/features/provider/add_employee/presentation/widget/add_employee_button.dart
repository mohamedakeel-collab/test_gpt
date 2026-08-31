part of '../imports/add_employee_imports.dart';

class _AddEmployeeButton extends StatelessWidget {
  const _AddEmployeeButton({required this.controller});

  final AddEmployeeViewController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEmployeeCubit, AsyncState<EmployeeEntity>>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(AppPadding.pH16),
          color: AppColors.white,
          child: LoadingButton(
            title: LocaleKeys.createEmployee,
            color: AppColors.primary,
            textColor: AppColors.splashBackground,
            borderRadius: AppCircular.r12,
            isDisabled: state.isLoading,
            onTap: () async {
              if (!controller.validateForm()) {
                final imageError = controller.validateImage();
                if (imageError != null && context.mounted) {
                  MessageUtils.showSnackBar(
                    context: context,
                    baseStatus: BaseStatus.error,
                    message: imageError,
                  );
                }
                return;
              }

              await context
                  .read<AddEmployeeCubit>()
                  .createEmployee(controller.toParams());
            },
          ),
        );
      },
    );
  }
}
