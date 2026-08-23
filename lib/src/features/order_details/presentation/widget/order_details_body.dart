part of '../imports/order_details_imports.dart';

class _OrderDetailsBody extends StatelessWidget {
  const _OrderDetailsBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
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
