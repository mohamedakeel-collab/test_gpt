part of '../imports/my_team_imports.dart';

class TeamRequestCard extends StatelessWidget {
  const TeamRequestCard({
    super.key,
    required this.request,
    this.onDelete,
    this.onEdit,
    this.onTap,
    required this.controller,
  });

  final LeaveRequestEntity request;
  final MyTeamViewController controller;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final employee = request.employee;
    final isPending = request.status == 'pending';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppPadding.pH16),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.circular(AppCircular.r12),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                IconWidget(
                  icon: AppAssets.svg.baseSvg.person.path,
                  height: AppSize.sH40,
                ),

                12.szW,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        employee?.fullName.isNotEmpty == true
                            ? employee!.fullName
                            : LocaleKeys.failureUnknown,

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle().setMainTextColor.s16.semiBold,
                      ),

                      Text(
                        employee?.position ?? '',

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle().setHintColor.s12.regular,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    _TeamStatusBadge(
                      status: request.status,
                      statusText: request.statusText.isNotEmpty
                          ? request.statusText
                          : controller.statusLabel(request.status),
                    ),
                    if (isPending) ...[
                      8.szH,

                      Row(
                        children: [
                          GestureDetector(
                            onTap: onEdit,

                            child: Icon(
                              Icons.mode_edit_sharp,

                              color: AppColors.hintText,

                              size: AppSize.sH22,
                            ),
                          ),

                          16.szW,

                        //  GestureDetector(
                         //   onTap: onDelete,
//
                        //    child: IconWidget(
                        //      icon: AppAssets.svg.baseSvg.deleteAll.path,

                          //    height: AppSize.sH28,
                         //   ),
                        //  ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),

            const Divider(color: AppColors.border),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        LocaleKeys.duration,

                        style: const TextStyle().setHintColor.s12.regular,
                      ),

                      Text(
                        request.duration?.isNotEmpty == true
                            ? request.duration!
                            : LocaleKeys.failureUnknown,
                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle().setMainTextColor.s12.medium,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        LocaleKeys.requestReason,

                        style: const TextStyle().setHintColor.s12.regular,
                      ),

                      4.szH,

                      Text(
                        request.reason,

                        maxLines: 2,

                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle().setMainTextColor.s12.medium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
