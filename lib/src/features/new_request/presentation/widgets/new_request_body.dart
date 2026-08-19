part of '../imports/new_request_imports.dart';

class _NewRequestBody extends StatefulWidget {
  const _NewRequestBody({
    this.request,
    this.mode,
  });

  final RequestData? request;
  final RequestMode? mode;

  @override
  State<_NewRequestBody> createState() => _NewRequestBodyState();
}

class _NewRequestBodyState extends State<_NewRequestBody> {
  final TextEditingController _reasonController = TextEditingController();
  final ValueNotifier<int> selectedRequestType = ValueNotifier(0);

  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _permissionDate;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;
  File? _file;

  @override
  void dispose() {
    _reasonController.dispose();
    selectedRequestType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedRequestType,
      builder: (context, selectedType, _) {
        return Column(
          children: [
            8.szH,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (widget.mode == RequestMode.add)
                      _RequestTypeSelector(
                        selectedType: selectedRequestType,
                      ),

                    16.szH,

                    _RequestDatePicker(
                      isHourlyPermission: selectedType == 1,
                      startDate: _startDate,
                      endDate: _endDate,
                      permissionDate: _permissionDate,
                      onStartChanged: (date) => setState(() => _startDate = date),
                      onEndChanged: (date) => setState(() => _endDate = date),
                      onPermissionChanged: (date) =>
                          setState(() => _permissionDate = date),
                    ),

                    if (selectedType == 1) ...[
                      16.szH,
                      _RequestTimePicker(
                        fromTime: _fromTime,
                        toTime: _toTime,
                        onFromChanged: (time) => setState(() => _fromTime = time),
                        onToChanged: (time) => setState(() => _toTime = time),
                      ),
                    ],
                    if (selectedType == 0) ...[
                      16.szH,
                      _RequestAttachmentField(
                        file: _file,
                        onPick: _pickAttachment,
                      ),
                    ],

                    16.szH,

                    _RequestReasonField(controller: _reasonController),

                    16.szH,

                    const _ApprovalSection(),

                    16.szH,

                    const _BalanceInfoCard(),
                  ],
                ).paddingSymmetric(
                  horizontal: AppPadding.pH16,
                ),
              ),
            ),

            _SendRequestButton(
              onSubmit: widget.mode == RequestMode.add ? _submit : null,
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    final isHourly = selectedRequestType.value == 1;

    DateTime startDate;
    DateTime endDate;

    if (isHourly) {
      final date = _permissionDate;
      if (date == null) {
        _showRequiredFieldsError();
        return;
      }
      startDate = _withTime(date, _fromTime, defaultHour: 8);
      endDate = _withTime(date, _toTime, defaultHour: 10);
    } else {
      if (_startDate == null || _endDate == null) {
        _showRequiredFieldsError();
        return;
      }
      startDate = _withTime(_startDate!, null, defaultHour: 9);
      endDate = _withTime(_endDate!, null, defaultHour: 17);
    }

    if (_reasonController.text.trim().isEmpty) {
      _showRequiredFieldsError();
      return;
    }

    final params = CreateNewRequestParams(
      leaveType: _leaveTypeFor(selectedRequestType.value),
      startDate: startDate,
      endDate: endDate,
      reason: _reasonController.text.trim(),
      file: _file,
    );

    await context.read<NewRequestCubit>().submit(params);
  }

  void _showRequiredFieldsError() {
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

  Future<void> _pickAttachment() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result == null || result.files.isEmpty) return;

    final picked = result.files.first;
    if (picked.path == null) return;

    final extension = (picked.extension ?? '').toLowerCase();
    if (!const ['pdf', 'jpg', 'jpeg', 'png'].contains(extension)) {
      if (!mounted) return;
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.invalidFileType,
      );
      return;
    }

    if (picked.size > 5 * 1024 * 1024) {
      if (!mounted) return;
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.fileTooLarge,
      );
      return;
    }

    if (!mounted) return;
    setState(() => _file = File(picked.path!));
  }
}