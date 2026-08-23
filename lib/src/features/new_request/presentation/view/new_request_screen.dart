part of '../imports/new_request_imports.dart';

enum RequestMode {
  add,
  edit,
}

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({
    super.key,
    this.request,
    this.mode = RequestMode.add,
  });


  final LeaveRequestEntity? request;
  final RequestMode mode;

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  late final NewRequestCubit _cubit;
  late final NewRequestViewController _vc;

  @override
  void initState() {
    super.initState();
    _cubit = injector<NewRequestCubit>();
    _vc = NewRequestViewController();
  }

  @override
  void dispose() {
    _vc.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.mode == RequestMode.edit;

    return BlocProvider<NewRequestCubit>.value(
      value: _cubit,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.main,
        ),
        child: Scaffold(
          appBar: CustomAppBar(
            title: isEdit
                ? LocaleKeys.editRequest
                : LocaleKeys.newRequestTitle,
            showArrow: true,
            onTap: () {
              Go.back();
            },
          ),
          backgroundColor: AppColors.scaffoldBackground,
          body: _NewRequestBody(
            controller: _vc,
            request: widget.request,
            mode: widget.mode,
          ),
        ),
      ),
    );
  }
}