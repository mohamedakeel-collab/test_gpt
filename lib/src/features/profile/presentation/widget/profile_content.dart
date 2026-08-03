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
            title: 'رقم الهاتف',
            value: '+966 50 123 4567',
            icon: AppAssets.svg.baseSvg.phone.path,
          ),

          12.szH,

          _ProfileInfoItem(
            title: 'البريد الإلكتروني',
            value: 'ahmed.a@tagwinner.com',
            icon: AppAssets.svg.baseSvg.email.path,
          ),

          12.szH,

          _ProfileInfoItem(
            title: 'القسم',
            value: 'الإدارة والعمليات',
            icon: AppAssets.svg.baseSvg.department.path,
          ),

          16.szH,

          Row(
            children: [
              Expanded(
                child: _ProfileBalanceCard(
                  title: 'رصيد الإجازات',
                  value: '14',
                  sub: 'يوم',
                  isPermission: false,
                ),
              ),

              12.szW,

              Expanded(
                child: _ProfileBalanceCard(
                  title: 'الأذونات',
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
            title: 'إعدادات الحساب',
            icon: AppAssets.svg.baseSvg.settings.path,
          ),

          _ProfileMenuItem(
            title: 'الأمان والخصوصية',
            icon: AppAssets.svg.baseSvg.security.path,
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
