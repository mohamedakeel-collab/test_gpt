part of '../imports/employee_details_imports.dart';

class _EmployeeDetailsHeaderCard extends StatelessWidget {
  const _EmployeeDetailsHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.splashBackground,

        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),

      child: Column(
        children: [
          ProfileImageCard(
            image:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s',
          ),

          12.szH,

          Text('أحمد منصور', style: const TextStyle().setPrimaryColor.s18.bold),

          4.szH,

          Text(
            'مدير المشاريع التقنية',

            style: const TextStyle().setWhiteColor.s13.regular,
          ),

          8.szH,

          Text(
            'a.mansour@tagwinner.com',

            style: const TextStyle().setWhiteColor.s12.regular,
          ),

          4.szH,

          Text(
            '+966 50 123 4567',

            style: const TextStyle().setWhiteColor.s12.regular,
          ),

          16.szH,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingButton(
                title: LocaleKeys.sharing,
                width: 80.w,
                color: AppColors.primary,
                textColor: AppColors.splashBackground,
                borderRadius: AppCircular.r5,
                borderSide: BorderSide(color: AppColors.primary, width: 1),
                onTap: () async {},
              ),

              12.szW,
              LoadingButton(
                title: LocaleKeys.edite,
                width: 80.w,
                color: Colors.transparent,
                textColor: AppColors.primary,
                borderRadius: AppCircular.r5,
                borderSide: BorderSide(color: AppColors.primary, width: 1),
                onTap: () async {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
