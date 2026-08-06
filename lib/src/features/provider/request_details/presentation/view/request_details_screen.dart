part of '../imports/request_details_imports.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: CustomAppBar(
        title: LocaleKeys.requestDetails,
        showArrow: true,
      ),
      body: const _RequestDetailsBody(),
      bottomNavigationBar:
      const _RequestActionButtons(),
    );
  }
}