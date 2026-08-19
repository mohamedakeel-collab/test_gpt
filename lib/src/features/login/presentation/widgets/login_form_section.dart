part of '../imports/login_imports.dart';

class _LoginFormSec extends StatefulWidget {
  const _LoginFormSec({required this.vc});

  final LoginViewController vc;

  @override
  State<_LoginFormSec> createState() => _LoginFormSecState();
}

class _LoginFormSecState extends State<_LoginFormSec> with FormMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      transform: Matrix4.translationValues(0, -60.h, 0),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      child: Form(
        key: formKey,
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
            ).paddingOnly(top: AppPadding.pH25, bottom: AppPadding.pH4),
            DefaultTextField(
              borderColor: AppColors.border,
              title: LocaleKeys.loginEmailHint,
              inputType: TextInputType.emailAddress,
              action: TextInputAction.next,
              controller: widget.vc.emailController,
              validator: (v) =>
                  Validators.validateEmpty(v, fieldTitle: LocaleKeys.email),
              prefixIcon: IconWidget(
                icon: Icons.person_outline,
                color: AppColors.icons,
                height: 20.h,
              ),
            ),
            Text(
              LocaleKeys.password,
              style: const TextStyle().setLabelColor.s16.medium,
            ).paddingOnly(top: AppPadding.pH12, bottom: AppPadding.pH4),
            DefaultTextField(
              borderColor: AppColors.border,
              title: LocaleKeys.loginPasswordHint,
              isPassword: true,
              action: TextInputAction.done,
              controller: widget.vc.passwordController,
              validator: (v) =>
                  Validators.validateEmpty(v, fieldTitle: LocaleKeys.password),
              onSubmitted: (_) => _submit(context),
              suffixIcon: IconWidget(
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
            Center(child: LoadingButton(
              color: AppColors.primary,
              textColor: AppColors.splashBackground,
              title: LocaleKeys.login,
              onTap: () => _submit(context),
            ),)
            ,
          ],
        ),
      ),
    );
  }


  Future<void> _submit(BuildContext context) async {
    if (!validateAndScroll()) return;
    final cubit = context.read<LoginCubit>();
    await cubit.login(
      login: widget.vc.login,
      password: widget.vc.password,
    );
  }
}