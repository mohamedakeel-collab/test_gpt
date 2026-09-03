part of '../imports/add_employee_imports.dart';

class AddEmployeeViewController {
  AddEmployeeViewController({this.isEdit = false});

  final bool isEdit;
  EmployeeDetailsEntity? employee;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController roleController = TextEditingController(text: LocaleKeys.employee);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController initialLeaveBalanceController =
      TextEditingController();
  final TextEditingController initialPerissionsController =
      TextEditingController();

  final ValueNotifier<DepartmentEntity?> selectedDepartment =
      ValueNotifier<DepartmentEntity?>(null);
  final ValueNotifier<DepartmentEntity?> selectedManager =
      ValueNotifier<DepartmentEntity?>(null);

  File? attachment;

  String? existingImage;

  final ValueNotifier<File?> employeeImage = ValueNotifier<File?>(null);

  String? attachmentName;

  int? get selectedDepartmentId => selectedDepartment.value?.id;

  int? get selectedManagerId => selectedManager.value?.id;

  CreateEmployeeParams toParams() {
    return CreateEmployeeParams(
      image: employeeImage.value,
      fullName: fullNameController.text.trim(),
      position: jobTitleController.text.trim(),
      phone: mobileNumberController.text.trim(),
      departmentId: selectedDepartmentId!,
      email: emailController.text.trim(),
      password: passwordController.text,
      managerId: selectedManagerId!,
      remainingLeaveBalance:
          int.tryParse(initialLeaveBalanceController.text.trim()) ?? 0,
      balanceExpiration: DateTime.now()
          .add(const Duration(days: 365))
          .toString()
          .split('.')
          .first,
      permissionHours:
          int.tryParse(initialPerissionsController.text.trim()) ?? 0,
      role: 'employee',
    );
  }

  bool validateForm() {
    final formValid = formKey.currentState?.validate() ?? false;

    final hasImage = employeeImage.value != null || existingImage != null;

    return formValid && (isEdit || hasImage);
  }

  void setSelectedDepartment(DepartmentEntity? value) {
    selectedDepartment.value = value;
  }

  void setSelectedManager(DepartmentEntity? value) {
    selectedManager.value = value;
  }

  void clearSelectedManager() {
    selectedManager.value = null;
  }

  String? validateDepartment(DepartmentEntity? value) {
    return value == null ? LocaleKeys.selectSuitableDepartment : null;
  }

  String? validateManager(DepartmentEntity? value) {
    return value == null ? LocaleKeys.selectDirectManager : null;
  }

  String? validateImage() {
    if (isEdit && (employeeImage.value != null || existingImage != null)) {
      return null;
    }

    return employeeImage.value == null ? LocaleKeys.fillField : null;
  }

  Future<void> pickAttachment(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result == null || result.files.isEmpty) return;

    final picked = result.files.first;

    if (picked.path == null) return;

    final extension = (picked.extension ?? '').toLowerCase();

    if (!const ['pdf', 'jpg', 'jpeg', 'png'].contains(extension)) {
      return;
    }

    if (picked.size > 5 * 1024 * 1024) {
      if (!context.mounted) return;

      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.fileTooLarge,
      );

      return;
    }

    attachment = File(picked.path!);

    attachmentName = picked.name;
  }

  Future<void> pickEmployeeImage() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (result == null) return;

    employeeImage.value = File(result.path);
  }

  void prefillEmployee(EmployeeDetailsEntity employee) {
    this.employee = employee;

    fullNameController.text = employee.fullName;

    jobTitleController.text = employee.position;

    mobileNumberController.text = employee.phone;

    emailController.text = employee.email;

    existingImage = employee.image;

    selectedDepartment.value = DepartmentEntity(
      id: employee.department.id,
      name: employee.department.name,
      managerId: employee.manager.id,
      employeesCount: 0,
      managerName: '',
      phone: '',
      position: '',
    );

    selectedManager.value = DepartmentEntity(
      id: employee.manager.id,
      name: employee.manager.name,
      employeesCount: 0,
      managerName: '',
      phone: '',
      position: '',
      managerId: employee.manager.id,
    );

    initialLeaveBalanceController.text = employee.remainingLeaveBalance
        .toString();
  }

  void dispose() {
    fullNameController.dispose();
    jobTitleController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    initialLeaveBalanceController.dispose();
    employeeImage.dispose();
    selectedDepartment.dispose();
    selectedManager.dispose();
  }
}
