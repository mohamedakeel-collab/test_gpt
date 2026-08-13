part of '../imports/profile_imports.dart';

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
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
            value: '+966 50 123 4567',
            icon: AppAssets.svg.baseSvg.phone.path,
          ),

          12.szH,

          _ProfileInfoItem(
            title: LocaleKeys.email,
            value: 'ahmed.a@tagwinner.com',
            icon: AppAssets.svg.baseSvg.email.path,
          ),

          12.szH,

          _ProfileInfoItem(
            title: LocaleKeys.department,
            value: 'الإدارة والعمليات',
            icon: AppAssets.svg.baseSvg.department.path,
          ),

          16.szH,

          Row(
            children: [
              Expanded(
                child: _ProfileBalanceCard(
                  title: LocaleKeys.vacationBalance,
                  value: '14',
                  sub: 'يوم',
                  isPermission: false,
                ),
              ),

              12.szW,

              Expanded(
                child: _ProfileBalanceCard(
                  title: LocaleKeys.permissions,
                  value: '08',
                  sub: 'ساعة',
                  isPermission: true
                  ,
                ),
              ),
            ],
          ),

          20.szH,

          _ProfileMenuItem(
            title: LocaleKeys.accountSettings,
            icon: AppAssets.svg.baseSvg.settings.path,
          ),
          _ProfileMenuItem(
            onTap: (){
              Go.to(
                const RemoteWorkScreen(),
              );
            },
            title: LocaleKeys.remoteWork,
            icon: AppAssets.svg.baseSvg.remote.path,
          ),

          _LogoutButton(),
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
            style: const TextStyle()
                .setErrorColor
                .s14
                .medium,
          ),
        ],
      ),
    );
  }
}
