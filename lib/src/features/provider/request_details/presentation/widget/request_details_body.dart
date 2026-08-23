part of '../imports/request_details_imports.dart';

class _RequestDetailsBody extends StatelessWidget {
  const _RequestDetailsBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          16.szH,

          const RequestEmployeeCard(),

          16.szH,

          const RequestBalanceCard(),

          16.szH,

          const RequestInfoCard(),

          12.szH,
          const RequestAttachmentCard(),

          12.szH,

          const RequestNotesCard(),

          100.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
