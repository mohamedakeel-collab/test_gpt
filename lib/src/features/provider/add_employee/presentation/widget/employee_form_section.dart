part of '../imports/add_employee_imports.dart';

class _EmployeeFormSection extends StatelessWidget {
  const _EmployeeFormSection({required this.controller});

  final AddEmployeeViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.fullName,
          style: const TextStyle().setMainTextColor.s14.medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.enterEmployeeNameEnter,
          controller: controller.fullNameController,
          validator: (v) => Validators.validateEmpty(v, fieldTitle: LocaleKeys.fullName),
          prefixIcon: const Icon(Icons.person_outline),
        ),
        12.szH,
        Text(
          LocaleKeys.jobTitle,
          style: const TextStyle().setMainTextColor.s14.medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.jobTitleExample,
          controller: controller.jobTitleController,
          validator: (v) => Validators.validateEmpty(v, fieldTitle: LocaleKeys.jobTitle),
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
        12.szH,
        Text(
          LocaleKeys.mobileNumber,
          style: const TextStyle().setMainTextColor.s14.medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.mobileNumberHint,
          controller: controller.mobileNumberController,
          inputType: TextInputType.phone,
          validator: (v) => Validators.validatePhone(v, fieldTitle: LocaleKeys.mobileNumber),
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
        12.szH,
        AsyncBlocBuilder<DepartmentsCubit, List<DepartmentEntity>>(
          onRetry: () => context.read<DepartmentsCubit>().getDepartments(),
          builder: (context, departments) {
            if (departments.isEmpty) {
              return EmptyWidget(
                title: LocaleKeys.noDepartments,
                desc: LocaleKeys.errorexceptionNotcontaindesc,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<DepartmentEntity?>(
                  valueListenable: controller.selectedDepartment,
                  builder: (context, selectedDepartment, _) {
                    return AppDropdown<DepartmentEntity>(
                      items: departments,
                      value: selectedDepartment,
                      showSearchBox: false,
                      itemAsString: (item) => item.name,
                      onChanged: (value) {
                        controller.setSelectedDepartment(value);
                        controller.clearSelectedManager();
                        if (value != null) {
                          context
                              .read<DepartmentManagersCubit>()
                              .getManagers(value.id);
                        } else {
                          context.read<DepartmentManagersCubit>().resetManagers();
                        }
                      },
                      validator: controller.validateDepartment,
                      label: LocaleKeys.selectDepartment,
                      hint: LocaleKeys.selectSuitableDepartment,
                    );
                  },
                ),
                12.szH,
                ValueListenableBuilder<DepartmentEntity?>(
                  valueListenable: controller.selectedDepartment,
                  builder: (context, selectedDepartment, _) {
                    if (selectedDepartment == null) {
                      return ValueListenableBuilder<DepartmentEntity?>(
                        valueListenable: controller.selectedManager,
                        builder: (context, selectedManager, _) {
                          return AppDropdown<DepartmentEntity>(
                            items: const [],
                            value: selectedManager,
                            showSearchBox: false,
                            readonly: true,
                            itemAsString: (item) =>
                                item.managerName.isNotEmpty ? item.managerName : item.name,
                            onChanged: controller.setSelectedManager,
                            validator: controller.validateManager,
                            label: LocaleKeys.directManager,
                            hint: LocaleKeys.selectDirectManager,
                          );
                        },
                      );
                    }

                    return AsyncBlocBuilder<DepartmentManagersCubit, List<DepartmentEntity>>(
                      loadingBuilder: (_) {
                        return ValueListenableBuilder<DepartmentEntity?>(
                          valueListenable: controller.selectedManager,
                          builder: (context, selectedManager, _) {
                            return AppDropdown<DepartmentEntity>(
                              items: const [],
                              value: selectedManager,
                              showSearchBox: false,
                              readonly: true,
                              itemAsString: (item) =>
                                  item.managerName.isNotEmpty ? item.managerName : item.name,
                              onChanged: controller.setSelectedManager,
                              validator: (value) =>
                                  Validators.validateDropDown(value, fieldTitle: LocaleKeys.directManager),
                              label: LocaleKeys.directManager,
                              hint: LocaleKeys.loadingManagers,
                            );
                          },
                        );
                      },
                      builder: (context, managers) {
                        if (managers.isEmpty) {
                          return ValueListenableBuilder<DepartmentEntity?>(
                            valueListenable: controller.selectedManager,
                            builder: (context, selectedManager, _) {
                              return AppDropdown<DepartmentEntity>(
                                items: const [],
                                value: selectedManager,
                                showSearchBox: false,
                                readonly: true,
                                itemAsString: (item) =>
                                    item.managerName.isNotEmpty ? item.managerName : item.name,
                                onChanged: controller.setSelectedManager,
                                validator: (value) =>
                                    Validators.validateDropDown(value, fieldTitle: LocaleKeys.directManager),
                                label: LocaleKeys.directManager,
                                hint: LocaleKeys.noManagers,
                              );
                            },
                          );
                        }

                        return ValueListenableBuilder<DepartmentEntity?>(
                          valueListenable: controller.selectedManager,
                          builder: (context, selectedManager, _) {
                              return AppDropdown<DepartmentEntity>(
                                items: managers,
                                value: selectedManager,
                                showSearchBox: false,
                                itemAsString: (item) =>
                                    item.managerName.isNotEmpty ? item.managerName : item.name,
                                onChanged: controller.setSelectedManager,
                                validator: (value) =>
                                    Validators.validateDropDown(value, fieldTitle: LocaleKeys.directManager),
                                label: LocaleKeys.directManager,
                                hint: LocaleKeys.selectDirectManager,
                              );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
