part of '../imports/new_request_imports.dart';

class _NewRequestBody extends StatelessWidget {
  _NewRequestBody();

  final ValueNotifier<int> selectedRequestType = ValueNotifier(0);

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

                    _RequestTypeSelector(
                      selectedType: selectedRequestType,
                    ),

                    16.szH,

                    _RequestDatePicker(
                      isHourlyPermission: selectedType == 1,
                    ),


                    if (selectedType == 1) ...[
                      16.szH,
                      const _RequestTimePicker(),
                    ],


                    16.szH,

                    const _RequestReasonField(),

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

            const _SendRequestButton(),
          ],
        );
      },
    );
  }
}