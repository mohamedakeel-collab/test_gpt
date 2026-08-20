part of '../imports/new_request_imports.dart';

/// View-level state for the new-request form that doesn't belong in the cubit:
///   - the reason field controller
///   - the selected request type
///   - date / time / attachment pickers
///
/// Pattern
///   - Create in `initState`.
///   - Always call `dispose()` from the screen's `dispose`.
///   - The cubit owns server state (`AsyncState<NewRequestResultEntity>`);
///     this owns all ephemeral form state.
class NewRequestViewController {
  final TextEditingController reasonController = TextEditingController();
  final ValueNotifier<int> selectedRequestType = ValueNotifier(1);

  DateTime? startDate;
  DateTime? endDate;
  DateTime? permissionDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  File? file;

  String get reason => reasonController.text.trim();

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
      if (!context.mounted) return;
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.invalidFileType,
      );
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

    file = File(picked.path!);
  }

  Future<void> submit(BuildContext context, NewRequestCubit cubit) async {
    final isHourly = selectedRequestType.value == 1;

    DateTime start;
    DateTime end;

    if (isHourly) {
      final date = permissionDate;
      if (date == null) {
        _showRequiredFieldsError(context);
        return;
      }
      start = _withTime(date, fromTime, defaultHour: 8);
      end = _withTime(date, toTime, defaultHour: 10);
    } else {
      if (startDate == null || endDate == null) {
        _showRequiredFieldsError(context);
        return;
      }
      start = _withTime(startDate!, null, defaultHour: 9);
      end = _withTime(endDate!, null, defaultHour: 17);
    }

    if (reason.isEmpty) {
      _showRequiredFieldsError(context);
      return;
    }

    final params = CreateNewRequestParams(
      leaveType: _leaveTypeFor(selectedRequestType.value),
      startDate: start,
      endDate: end,
      reason: reason,
      file: file,
    );

    await cubit.submit(params);
  }

  void _showRequiredFieldsError(BuildContext context) {
    if (!context.mounted) return;
    MessageUtils.showSnackBar(
      context: context,
      baseStatus: BaseStatus.error,
      message: LocaleKeys.fillRequiredFields,
    );
  }

  String _leaveTypeFor(int index) => switch (index) {
        1 => 'sick',
        2 => 'permission',
        3 => 'remote',
        _ => 'leave',
      };

  DateTime _withTime(
    DateTime date,
    TimeOfDay? time, {
    required int defaultHour,
  }) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time?.hour ?? defaultHour,
      time?.minute ?? 0,
    );
  }

  void dispose() {
    reasonController.dispose();
    selectedRequestType.dispose();
  }
}
