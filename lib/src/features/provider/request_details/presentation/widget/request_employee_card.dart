part of '../imports/request_details_imports.dart';

class RequestEmployeeCard extends StatelessWidget {
  const RequestEmployeeCard({super.key, this.employee});

  final EmployeeEntity? employee;

  @override
  Widget build(BuildContext context) {
    final data = employee ?? EmployeeEntity.initial();

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
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppCircular.infinity),
            ),
            child: IconWidget(
              icon: AppAssets.svg.baseSvg.profile.path,
              width: AppSize.sW55,
              height: AppSize.sW55,
            ),
          ),
          12.szW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().setPrimaryColor.s15.bold,
                ),
                4.szH,
                Text(
                  data.position,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle().setWhiteColor.s12.regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
