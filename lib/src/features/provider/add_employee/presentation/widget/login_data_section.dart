part of '../imports/add_employee_imports.dart';

class _LoginDataSection extends StatelessWidget {
  const _LoginDataSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Divider(
          color: AppColors.primary,
          thickness: 2,
        ),


        16.szH,


        Text(
          LocaleKeys.loginInformation,

          style: const TextStyle()
              .setMainTextColor
              .s16
              .bold,
        ),


        16.szH,


        Text(
          LocaleKeys.email,

          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.emailHint,

          prefixIcon: const Icon(
            Icons.email_outlined,
          ),
        ),


        12.szH,


        Text(
          LocaleKeys.temporaryPassword,

          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.passwordHint,

          isPassword: true,

          prefixIcon: const Icon(
            Icons.visibility_off_outlined,
          ),
        ),


        16.szH,


        Text(
          LocaleKeys.initialLeaveBalance,

          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: '0',

          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
          ),
        ),
        5.szH,
        Text(
          LocaleKeys.titleInitialLeaveBalance,

          style: const TextStyle()
              .subLabelColor
              .s10
              .medium,
        ),
      ],
    );
  }
}