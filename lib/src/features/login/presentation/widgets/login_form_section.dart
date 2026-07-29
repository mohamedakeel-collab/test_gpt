part of '../imports/login_imports.dart';

class _LoginFormSec extends StatelessWidget {
  const _LoginFormSec();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      transform: Matrix4.translationValues(0, -60.h, 0),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      margin:  EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  LocaleKeys.welcomeBack,
                  style: const TextStyle().setHintColor.s16.regular,
                ),
                12.szH,
                Text(
                  LocaleKeys.loginTitle,
                  style: const TextStyle().subHintColor.s14.regular,
                ),
              ],
            ),
          ),
          Text(
            LocaleKeys.email,
            style: const TextStyle().setLabelColor.s16.medium,
          ).paddingOnly(top:AppPadding.pH25,bottom: AppPadding.pH4 ),
          DefaultTextField(
            borderColor:AppColors.border,
            title: LocaleKeys.loginEmailHint,
            inputType: TextInputType.emailAddress,
            action: TextInputAction.next,
            prefixIcon: IconWidget(
              icon: Icons.person_outline,
              color: AppColors.icons,
              height: 20.h,
            ),
          ),
          Text(
            LocaleKeys.password,
            style: const TextStyle().setLabelColor.s16.medium,
          ).paddingOnly(top: AppPadding.pH12 ,bottom: AppPadding.pH4),
          DefaultTextField(
            borderColor:AppColors.border,
            title: LocaleKeys.loginPasswordHint,
            isPassword: true,
            action: TextInputAction.done,
            suffixIcon:IconWidget(
              icon: Icons.remove_red_eye_outlined,
              color: AppColors.icons,
              height: 20.h,
            ),
            prefixIcon: IconWidget(
              icon: Icons.lock_open_outlined,
              color: AppColors.icons,
              height: 20.h,
            ),
          ),
          8.szH,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              LocaleKeys.loginForgotPassword,
              style: const TextStyle().setBrandSurfaceColor.s14.bold,
            ),
          ),
          8.szH,
          LoadingButton(
            color: AppColors.primary,
            textColor: AppColors.splashBackground,
            title: LocaleKeys.login,
            onTap: () async {Go.to(MainTapScreen());},
          ),
        ],
      ),
    );
  }
}
