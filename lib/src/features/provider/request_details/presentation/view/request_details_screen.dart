part of '../imports/request_details_imports.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  late final RequestDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = injector<RequestDetailsCubit>()..getRequestDetails(widget.id);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestDetailsCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: CustomAppBar(
          title: LocaleKeys.requestDetails,
          showArrow: true,
        ),
        body: _RequestDetailsBody(requestId: widget.id),
        bottomNavigationBar: const _RequestActionButtons(),
      ),
    );
  }
}
