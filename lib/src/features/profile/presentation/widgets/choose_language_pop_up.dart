part of '../../../login/presentation/imports/login_imports.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({super.key});

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  late Languages _selected = Languages.currentLanguage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.chooseLanguage,
                style: const TextStyle().setLabelColor.s18.bold,
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: AppColors.icons),
              ),
            ],
          ),

          16.szH,

          ...Languages.values.map((lang) {
            final isSelected = _selected == lang;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () => setState(() => _selected = lang),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.brandSurface.withOpacity(0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.brandSurface
                          : AppColors.border,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.brandSurface
                              : AppColors.border,
                        ),
                        child: Text(
                          lang.languageCode == 'ar' ? 'ع' : 'En',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      12.szW,
                      Text(
                        lang == Languages.arabic
                            ? LocaleKeys.arabic.tr()
                            : LocaleKeys.english.tr(),
                        style: const TextStyle().setLabelColor.s16.medium,
                      ),
                      const Spacer(),

                      Container(
                        width: 22.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.brandSurface
                                : AppColors.border,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 11.w,
                                  height: 11.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.brandSurface,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          8.szH,
          LoadingButton(
            color: AppColors.primary,
            textColor: AppColors.splashBackground,
            fontSize: FontSizeManager.s16,
            title: LocaleKeys.confirm,
            onTap: () async {
              Go.to(HomeScreen());
            },
          ),
        ],
      ),
    );
  }
}
