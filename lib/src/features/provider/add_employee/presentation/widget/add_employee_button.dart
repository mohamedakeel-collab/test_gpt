
part of '../imports/add_employee_imports.dart';

class _AddEmployeeButton extends StatelessWidget {

  const _AddEmployeeButton();


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
      EdgeInsets.all(
        AppPadding.pH16,
      ),


      color:
      AppColors.white,


      child: LoadingButton(

        title:
        LocaleKeys.saveAndSendLoginData,


        color:
        AppColors.primary,


        textColor:
        AppColors.splashBackground,


        borderRadius:
        AppCircular.r12,


        onTap: () async {},

      ),
    );
  }
}