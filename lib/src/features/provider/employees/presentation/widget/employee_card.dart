part of '../imports/employees_imports.dart';

class _EmployeeCard extends StatelessWidget {
  const _EmployeeCard({
    required this.name,
    required this.job,
    required this.status,
    required this.image,
    this.onTap,
  });

  final String name;
  final String job;
  final String status;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppPadding.pH12),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.circular(AppCircular.r12),
        ),

        child: Row(
          children: [
            Container(
              width: AppSize.sW60,
              height: AppSize.sH60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.fill, width: 2),
              ),
              child: ClipOval(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return AppAssets.svg.baseSvg.person.svg();
                  },
                ),
              ),
            ),

            12.szW,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    name,maxLines: 1,
                    style: const TextStyle().setMainTextColor.s14.medium,
                  ),

                  Text(job,maxLines: 1, style: const TextStyle().setHintColor.s12.regular),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW8,
                vertical: AppPadding.pH4,
              ),

              decoration: BoxDecoration(
                color: AppColors.statusEmployee,

                borderRadius: BorderRadius.circular(AppCircular.r20),
              ),

              child: Text(
                status,

                style: const TextStyle().setWhiteColor.s11.medium,
              ),
            ),
            10.szW,
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.icons,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
