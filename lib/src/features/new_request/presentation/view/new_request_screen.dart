part of '../imports/new_request_imports.dart';
enum RequestMode {
  add,
  edit,
}


class NewRequestScreen extends StatelessWidget {
  const NewRequestScreen({
    super.key,
    this.request,
    this.mode = RequestMode.add,
  });


  final RequestData? request;
  final RequestMode mode;


  @override
  Widget build(BuildContext context) {

    final isEdit = mode == RequestMode.edit;


    return AnnotatedRegion<SystemUiOverlayStyle>(
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


          onTap: (){
            Go.back();
          },
        ),


        backgroundColor:
        AppColors.scaffoldBackground,


        body: _NewRequestBody(
          request: request,
          mode: mode,
        ),
      ),
    );
  }
}
