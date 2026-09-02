part of '../imports/employees_imports.dart';

class _EmployeeCard extends StatelessWidget {
  const _EmployeeCard({
    required this.employee,
    required this.controller,
    this.onTap,
  });

  final EmployeeEntity employee;
  final EmployeesViewController controller;
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
                child: employee.image.isEmpty
                    ? AppAssets.svg.baseSvg.person.svg(
                        fit: BoxFit.cover,
                        width: AppSize.sW60,
                        height: AppSize.sH60,
                      )
                    : CachedImage(
                        url: employee.image,
                        fit: BoxFit.cover,
                        width: AppSize.sW60,
                        height: AppSize.sH60,
                        ignoreClick: false,
                      ),
              ),
            ),

            12.szW,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    employee.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle().setMainTextColor.s14.medium,
                  ),

                  Text(
                    employee.position,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle().setHintColor.s12.regular,
                  ),
                ],
              ),
            ),

            if (employee.hasPendingRequests)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW8,
                  vertical: AppPadding.pH4,
                ),

                decoration: BoxDecoration(
                  color: controller.statusSurface(employee),

                  borderRadius: BorderRadius.circular(AppCircular.r20),
                ),

                child: Text(
                  LocaleKeys.pendingRequest,
                  style: const TextStyle().setWhiteColor.s11.medium.copyWith(
                    color: controller.statusColor(employee),
                  ),
                ),
              ),
            10.szW,
            IconWidget(
              icon: Icons.arrow_forward_ios_rounded,
              color: AppColors.icons,
              height: AppSize.sH18,
            ),
          ],
        ),
      ),
    );
  }
}
