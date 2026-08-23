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
  String? existingFileName;

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

  void prefillFromRequest(LeaveRequestEntity request) {
    reasonController.text = request.reason;
    selectedRequestType.value = requestTypeFromLeaveType(request.leaveType);
    existingFileName = _fileNameFromUrl(request.file);

    final parsedStart = _parseRequestDate(request.startDate);
    final parsedEnd = _parseRequestDate(request.endDate);

    if (selectedRequestType.value == 2) {
      permissionDate = parsedStart;
      if (parsedStart != null) {
        fromTime = TimeOfDay(
          hour: parsedStart.hour,
          minute: parsedStart.minute,
        );
      }
      if (parsedEnd != null) {
        toTime = TimeOfDay(hour: parsedEnd.hour, minute: parsedEnd.minute);
      }
      return;
    }

    startDate = parsedStart;
    endDate = parsedEnd;
  }

  Future<void> submit(
    BuildContext context,
    NewRequestCubit cubit, {
    required RequestMode mode,
    int? requestId,
  }) async {
    if (mode == RequestMode.edit && (requestId == null || requestId <= 0)) {
      _showRequiredFieldsError(context);
      return;
    }

    final isHourly = selectedRequestType.value == 2;

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

    await cubit.submit(mode: mode, requestId: requestId, params: params);
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
    1 => 'leave',
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

  int requestTypeFromLeaveType(String leaveType) {
    return switch (leaveType) {
      'leave' => 1,
      'permission' => 2,
      'remote' => 3,
      'sick' => 1,
      _ => 1,
    };
  }

  DateTime? _parseRequestDate(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value) ?? Helpers.parseArabicDate(value);
  }

  String? _fileNameFromUrl(String? value) {
    if (value == null || value.isEmpty) return null;
    return Uri.tryParse(value)?.pathSegments.lastOrNull ?? value;
  }
}
