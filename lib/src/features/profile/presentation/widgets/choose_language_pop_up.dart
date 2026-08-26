part of '../imports/profile_imports.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({super.key});

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  late Languages _selected = Languages.currentLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, AsyncState<LoginEntity>>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) async {
        switch (state) {
          case AsyncSuccess<LoginEntity>(:final data):
            await Languages.setLocale(_selected);

            if (!context.mounted) return;
            final userCubit = context.read<UserCubit>();
            final currentUser = userCubit.user;
            final updatedUser = data.toUserModel();
            await userCubit.updateUser(
              UserModel(
                id: updatedUser.id,
                image: updatedUser.image,
                fullName: updatedUser.fullName,
                phoneNumber: updatedUser.phoneNumber,
                email: updatedUser.email,
                role: updatedUser.role,
                userType: updatedUser.userType,
                position: updatedUser.position,
                department: updatedUser.department,
                team: updatedUser.team,
                remainingLeaveBalance: updatedUser.remainingLeaveBalance,
                permissionHours: updatedUser.permissionHours,
                allowNotify: updatedUser.allowNotify,
                token: currentUser.token,
              ),
            );
            if (!context.mounted) return;
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.success,
              message: LocaleKeys.languageUpdatedSuccessfully,
            );
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          case AsyncFailure<LoginEntity>(:final failure):
            if (failure is! CancelledFailure) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.error,
                message: failure.userMessage,
              );
            }
          default:
            break;
        }
      },
      child: Container(
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
            AsyncBlocBuilder<LanguageCubit, LoginEntity>(
              loadingBuilder: (_) => _buildConfirmButton(context),
              errorBuilder: (_, _) => _buildConfirmButton(context),
              initialBuilder: (_) => _buildConfirmButton(context),
              builder: (_, _) => _buildConfirmButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return LoadingButton(
      color: AppColors.primary,
      textColor: AppColors.splashBackground,
      fontSize: FontSizeManager.s16,
      title: LocaleKeys.confirm,
      onTap: () async {
        await context.read<LanguageCubit>().changeLanguage(
          _selected.languageCode,
        );
      },
    );
  }
}
