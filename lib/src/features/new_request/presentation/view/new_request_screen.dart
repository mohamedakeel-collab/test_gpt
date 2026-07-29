part of '../imports/new_request_imports.dart';

class NewRequestScreen extends StatelessWidget {
   NewRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.main,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.newRequestTitle,
          showArrow: true,onTap: (){
          Go.back();
        },),
        backgroundColor: AppColors.scaffoldBackground,
        body: _NewRequestBody(),
      ),
    );
  }
}
