part of '../imports/employee_details_imports.dart';

class _EmployeeDetailsHeaderCard extends StatelessWidget {
  const _EmployeeDetailsHeaderCard({required this.employee});

  final EmployeeEntity employee;

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
            image: employee.image.isEmpty
                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s'
                : employee.image,
          ),

          12.szH,

          Text(
            employee.fullName,
            style: const TextStyle().setPrimaryColor.s18.bold,
          ),

          4.szH,

          Text(
            employee.position,

            style: const TextStyle().setWhiteColor.s13.regular,
          ),

          8.szH,

          Text(
            employee.department,

            style: const TextStyle().setWhiteColor.s12.regular,
          ),

          4.szH,

          Text(
            employee.phone,

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
