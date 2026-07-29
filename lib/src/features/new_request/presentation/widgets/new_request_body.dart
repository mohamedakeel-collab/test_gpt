part of '../imports/new_request_imports.dart';

class _NewRequestBody extends StatelessWidget {
  _NewRequestBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _RequestTypeSelector(),

                16.szH,

                const _RequestDatePicker(),

                16.szH,

                const _RequestReasonField(),

                16.szH,

                _ApprovalSection(),

                16.szH,

                const _BalanceInfoCard(),
              ],
            ).paddingSymmetric(horizontal: AppPadding.pH16),
          ),
        ),

        const _SendRequestButton(),
      ],
    );
  }
}
