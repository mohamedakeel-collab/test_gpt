part of '../imports/request_details_imports.dart';

class _RequestEmployeeCard extends StatelessWidget {
  const _RequestEmployeeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.splashBackground,

        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),

      child: Row(
        children: [
          ProfileImageCard(
            image:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s',

            size: AppSize.sW55,
          ),

          12.szW,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'أحمد منصور',

                style: const TextStyle().setPrimaryColor.s15.bold,
              ),

              Text(
                'مطور برمجيات - الفريق التقني',

                style: const TextStyle().setWhiteColor.s12.regular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
