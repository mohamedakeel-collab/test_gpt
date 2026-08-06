part of '../imports/request_details_imports.dart';

class _RequestDetailsBody extends StatelessWidget {
  const _RequestDetailsBody();


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          16.szH,


          const _RequestEmployeeCard(),


          16.szH,


          const _RequestBalanceCard(),


          16.szH,


          const _RequestInfoCard(),


          12.szH,


          const _RequestReasonCard(),


          12.szH,


          const _RequestNotesCard(),


          100.szH,

        ],
      ).paddingSymmetric(
        horizontal: AppPadding.pH16,
      ),
    );
  }
}