part of '../imports/order_details_imports.dart';

class RequestEmployeeCard extends StatelessWidget {
  const RequestEmployeeCard({super.key, required this.employee});

  final EmployeeDetailsEntity employee;

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
          Container(
            width: AppSize.sW55,
            height: AppSize.sW55,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppCircular.infinity),
            ),
            child: employee.image?.isNotEmpty ?? false
                ? CachedImage(
                    url: employee.image!,
                    width: AppSize.sW55,
                    height: AppSize.sW55,
                    fit: BoxFit.cover,
                  )
                : IconWidget(
                    icon: AppAssets.svg.baseSvg.profile.path,
                    width: AppSize.sW55,
                    height: AppSize.sW55,
                    fit: BoxFit.cover,
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
                  style: const TextStyle().setPrimaryColor.s15.bold,
                ),
                4.szH,
                Text(
                  employee.position,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().setWhiteColor.s12.regular,
                ),
                if (employee.phone.isNotEmpty) ...[
                  4.szH,
                  Text(
                    employee.phone,
                    style: const TextStyle().setWhiteColor.s12.regular,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
