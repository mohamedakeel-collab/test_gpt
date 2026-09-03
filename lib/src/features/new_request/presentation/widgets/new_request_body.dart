part of '../imports/new_request_imports.dart';

class _NewRequestBody extends StatefulWidget {
  const _NewRequestBody({required this.controller, this.request, this.mode});

  final NewRequestViewController controller;
  final LeaveRequestEntity? request;
  final RequestMode? mode;

  @override
  State<_NewRequestBody> createState() => _NewRequestBodyState();
}

class _NewRequestBodyState extends State<_NewRequestBody> {
  NewRequestViewController get _vc => widget.controller;

  @override
  void initState() {
    super.initState();

    final isEdit =
        widget.mode == RequestMode.edit ||
        widget.mode == RequestMode.editProvider;
    if (isEdit && widget.request != null) {
      _vc.prefillFromRequest(widget.request!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _vc.selectedRequestType,
      builder: (context, selectedType, _) {
        return Column(
          children: [
            8.szH,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RequestTypeSelector(
                      selectedType: _vc.selectedRequestType,
                      isEdit:
                          widget.mode == RequestMode.edit ||
                          widget.mode == RequestMode.editProvider,
                      leaveType: widget.request?.leaveType,
                    ),

                    16.szH,

                    _RequestDatePicker(
                      isHourlyPermission: selectedType == 2,
                      startDate: _vc.startDate,
                      endDate: _vc.endDate,
                      permissionDate: _vc.permissionDate,
                      onStartChanged: (date) =>
                          setState(() => _vc.startDate = date),
                      onEndChanged: (date) =>
                          setState(() => _vc.endDate = date),
                      onPermissionChanged: (date) =>
                          setState(() => _vc.permissionDate = date),
                    ),

                    if (selectedType == 2) ...[
                      16.szH,
                      _RequestTimePicker(
                        fromTime: _vc.fromTime,
                        toTime: _vc.toTime,
                        onFromChanged: (time) =>
                            setState(() => _vc.fromTime = time),
                        onToChanged: (time) =>
                            setState(() => _vc.toTime = time),
                      ),
                    ],
                    if (selectedType == 1) ...[
                      16.szH,
                      _RequestAttachmentField(
                        file: _vc.file,
                        existingFileName: _vc.existingFileName,
                        onPick: _pickAttachment,
                      ),
                    ],

                    16.szH,

                    _RequestReasonField(controller: _vc.reasonController),

                    16.szH,

                    const _ApprovalSection(),

                    16.szH,

                    _BalanceInfoCard(selectedType: _vc.selectedRequestType),
                  ],
                ).paddingSymmetric(horizontal: AppPadding.pH16),
              ),
            ),

            _SendRequestButton(
              mode: widget.mode ?? RequestMode.add,
              onSubmit: _submit,
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    final user = context.read<UserCubit>().user;

    final balance = _vc.selectedRequestType.value == 1
        ? user.remainingLeaveBalance
        : user.permissionHours;

    if (balance <= 0) {
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.balanceValidation,
      );

      return;
    }

    final cubit = context.read<NewRequestCubit>();

    await _vc.submit(
      context,
      cubit,
      mode: widget.mode ?? RequestMode.add,
      requestId: widget.request?.id,
    );
  }

  Future<void> _pickAttachment() async {
    await _vc.pickAttachment(context);
    if (mounted) setState(() {});
  }
}
