part of '../imports/add_employee_imports.dart';

class _EmployeeFormSection extends StatelessWidget {
  const _EmployeeFormSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          LocaleKeys.fullName,
          maxLines: 1,
          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.enterEmployeeNameEnter,

          prefixIcon: const Icon(
            Icons.person_outline,
          ),
        ),


        12.szH,


        Text(
          LocaleKeys.jobTitle,
          maxLines: 1,
          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.jobTitleExample,

          prefixIcon: const Icon(
            Icons.badge_outlined,
          ),
        ),


        12.szH,


        Text(
          LocaleKeys.mobileNumber,
          maxLines: 1,
          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.mobileNumberHint,

          prefixIcon: const Icon(
            Icons.phone_outlined,
          ),
        ),


        12.szH,


        Text(
          LocaleKeys.selectTeam,
          maxLines: 1,
          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.selectSuitableTeam,

          prefixIcon: const Icon(
            Icons.groups_outlined,
          ),
        ),


        12.szH,


        Text(
          LocaleKeys.directManager,
          maxLines: 1,
          style: const TextStyle()
              .setMainTextColor
              .s14
              .medium,
        ),
        5.szH,
        DefaultTextField(
          title: LocaleKeys.selectDirectManager,

          prefixIcon: const Icon(
            Icons.supervisor_account_outlined,
          ),
        ),

      ],
    );
  }
}