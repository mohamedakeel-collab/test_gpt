
part of '../imports/remote_work_imports.dart';

class RemoteWorkScreen extends StatelessWidget {
  const RemoteWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: CustomAppBar(
        title: LocaleKeys.remoteWork,
          showArrow: true,
          onTap: () {
            Go.back();
          }
      ),

      body: const _RemoteWorkBody(),
    );
  }
}