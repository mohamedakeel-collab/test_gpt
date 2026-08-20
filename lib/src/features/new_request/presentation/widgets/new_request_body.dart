part of '../imports/new_request_imports.dart';

class _NewRequestBody extends StatefulWidget {
  const _NewRequestBody({
    required this.controller,
    this.request,
    this.mode,
  });

  final NewRequestViewController controller;
  final RequestData? request;
  final RequestMode? mode;

  @override
  State<_NewRequestBody> createState() => _NewRequestBodyState();
}

class _NewRequestBodyState extends State<_NewRequestBody> {
  NewRequestViewController get _vc => widget.controller;

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
                  children: [
                    if (widget.mode == RequestMode.add)
                      _RequestTypeSelector(selectedType: _vc.selectedRequestType),

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
                        onPick: _pickAttachment,
                      ),
                    ],

                    16.szH,

                    _RequestReasonField(controller: _vc.reasonController),

                    16.szH,

                    const _ApprovalSection(),

                    16.szH,

                    const _BalanceInfoCard(),
                  ],
                ).paddingSymmetric(horizontal: AppPadding.pH16),
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
    final cubit = context.read<NewRequestCubit>();
    await _vc.submit(context, cubit);
  }

  Future<void> _pickAttachment() async {
    await _vc.pickAttachment(context);
    if (mounted) setState(() {});
  }
}
