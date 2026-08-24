part of '../imports/profile_imports.dart';

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile, required this.controller});

  final LoginEntity profile;
  final ProfileViewController controller;

  @override
  Widget build(BuildContext context) {
    final employee = profile.employee ?? EmployeeEntity.initial();
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),
      margin: EdgeInsets.symmetric(horizontal: AppPadding.pH16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Column(
        children: [
          _ProfileInfoItem(
            title: LocaleKeys.phoneNumber,
            value: employee.phone,
            icon: AppAssets.svg.baseSvg.phone.path,
          ),
          12.szH,
          _ProfileInfoItem(
            title: LocaleKeys.email,
            value: profile.email,
            icon: AppAssets.svg.baseSvg.email.path,
          ),
          12.szH,
          _ProfileInfoItem(
            title: LocaleKeys.role,
            value: profile.role,
            icon: AppAssets.svg.baseSvg.person.path,
          ),
          12.szH,
          _ProfileInfoItem(
            title: LocaleKeys.department,
            value: employee.department?.name ?? '',
            icon: AppAssets.svg.baseSvg.department.path,
          ),
          12.szH,
          _ProfileInfoItem(
            title: LocaleKeys.team,
            value: employee.team?.teamName ?? '',
            icon: AppAssets.svg.baseSvg.team.path,
          ),
          16.szH,
          Row(
            children: [
              Expanded(
                child: _ProfileBalanceCard(
                  title: LocaleKeys.leaveBalance,
                  value: '${employee.remainingLeaveBalance}',
                  sub: LocaleKeys.day,
                  isPermission: false,
                ),
              ),
              12.szW,
              Expanded(
                child: _ProfileBalanceCard(
                  title: LocaleKeys.permissionHours,
                  value: '${employee.permissionHours}',
                  sub: LocaleKeys.hour,
                  isPermission: true,
                ),
              ),
            ],
          ),
          20.szH,
          _ProfileMenuItem(
            title: LocaleKeys.accountSettings,
            icon: AppAssets.svg.baseSvg.settings.path,
          ),
          if (F.appFlavor == Flavor.user)
            _ProfileMenuItem(
              onTap: () {
                Go.to(const RemoteWorkScreen());
              },
              title: LocaleKeys.remoteWork,
              icon: AppAssets.svg.baseSvg.remote.path,
            ),
          const _LogoutButton(),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          IconWidget(
            icon: AppAssets.svg.baseSvg.logout.path,
            height: AppSize.sH22,
          ),
          15.szW,
          Text(
            LocaleKeys.logout,
            style: const TextStyle().setErrorColor.s14.medium,
          ),
        ],
      ),
    );
  }
}
