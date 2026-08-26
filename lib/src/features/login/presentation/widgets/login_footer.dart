part of '../imports/login_imports.dart';

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<Languages>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: context.read<LanguageCubit>(),
            child: const LanguageSelectionSheet(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 150.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp),
          boxShadow: [
            BoxShadow(
              color: AppColors.border,
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconWidget(
              icon: Icons.language,
              color: AppColors.icons,
              height: 20.h,
            ).paddingSymmetric(horizontal: 10.w),
            Text(
              context.locale.languageCode == 'ar'
                  ? LocaleKeys.arabic
                  : LocaleKeys.english,
              style: const TextStyle().setLabelColor.s16.medium,
            ).paddingOnly(left: AppPadding.pW12),
          ],
        ),
      ),
    );
  }
}
