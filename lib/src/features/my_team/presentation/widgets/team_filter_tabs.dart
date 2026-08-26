part of '../imports/my_team_imports.dart';

class _TeamFilterTabs extends StatelessWidget {
  const _TeamFilterTabs({required this.controller});

  final MyTeamViewController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: controller.selectedStatus,
      builder: (context, selected, _) {
        return Row(
          children: [

            Expanded(
              child: _TeamTab(
                title: LocaleKeys.pending,
                active: selected == 'pending',
                onTap: () => controller.selectStatus('pending'),
              ),
            ),

            8.szW,

            Expanded(
              child: _TeamTab(
                title: LocaleKeys.approved,
                active: selected == 'approved',
                onTap: () => controller.selectStatus('approved'),
              ),
            ),

            8.szW,

            Expanded(
              child: _TeamTab(
                title: LocaleKeys.rejected,
                active: selected == 'rejected',
                onTap: () => controller.selectStatus('rejected'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TeamTab extends StatelessWidget {
  const _TeamTab({
    required this.title,
    required this.active,
    required this.onTap,
  });

  final String title;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: EdgeInsets.symmetric(vertical: AppPadding.pH8),

        decoration: BoxDecoration(
          color: active ? AppColors.brandSurface : AppColors.white,

          borderRadius: BorderRadius.circular(AppCircular.r20),

          border: Border.all(
            color: active ? AppColors.brandSurface : AppColors.border,
          ),
        ),

        child: Text(
          title,

          textAlign: TextAlign.center,

          style: active
              ? const TextStyle().setWhiteColor.s13.medium
              : const TextStyle().setLabelColor.s13.medium,
        ),
      ),
    );
  }
}
