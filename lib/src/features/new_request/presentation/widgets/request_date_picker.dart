part of '../imports/new_request_imports.dart';

class _RequestDatePicker extends StatelessWidget {
  const _RequestDatePicker({
    required this.isHourlyPermission,
    this.startDate,
    this.endDate,
    this.permissionDate,
    this.onStartChanged,
    this.onEndChanged,
    this.onPermissionChanged,
  });

  final bool isHourlyPermission;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? permissionDate;
  final ValueChanged<DateTime?>? onStartChanged;
  final ValueChanged<DateTime?>? onEndChanged;
  final ValueChanged<DateTime?>? onPermissionChanged;

  @override
  Widget build(BuildContext context) {
    if (isHourlyPermission) {
      return _DateField(
        title: LocaleKeys.permissionDate,
        value: permissionDate,
        onChanged: onPermissionChanged,
      );
    }

    return Row(
      children: [
        Expanded(
          child: _DateField(
            title: LocaleKeys.startDate,
            value: startDate,
            onChanged: onStartChanged,
          ),
        ),

        12.szW,

        Expanded(
          child: _DateField(
            title: LocaleKeys.endDate,
            value: endDate,
            onChanged: onEndChanged,
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.title, this.value, this.onChanged});

  final String title;
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle().setHintColor.s12.regular),

        6.szH,

        GestureDetector(
          onTap: () => _pickDate(),
          child: Container(
            height: AppSize.sH42,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppCircular.r10),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              value == null ? 'mm/dd/yyyy' : _formatDate(value!),
              style: value == null
                  ? const TextStyle().setHintColor.s12.regular
                  : const TextStyle().setMainTextColor.s12.regular,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();

    final picked = await showCustomDatePicker(
      initialDate: value,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: DateTime(now.year + 2, now.month, now.day),
    );

    if (picked != null) {
      onChanged?.call(picked);
    }
  }
}

String _formatDate(DateTime date) {
  String pad(int n) => n.toString().padLeft(2, '0');
  return '${pad(date.day)}/${pad(date.month)}/${date.year}';
}
