part of '../imports/new_request_imports.dart';

class _RequestTypeSelector extends StatelessWidget {
  const _RequestTypeSelector({
    required this.selectedType,
    this.isEdit = false,
    this.leaveType,
  });

  final ValueNotifier<int> selectedType;
  final bool isEdit;
  final String? leaveType;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedType,

      builder: (context, selected, _) {
        if (isEdit) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                LocaleKeys.requestType,

                style: const TextStyle().setMainTextColor.s14.semiBold,
              ),

              8.szH,

              _TypeButton(
                title: _typeTitle(leaveType),
                active: true,
                onTap: () {},
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              LocaleKeys.requestType,

              style: const TextStyle().setMainTextColor.s14.semiBold,
            ),

            8.szH,

            Row(
              children: [
                _TypeButton(
                  title: LocaleKeys.sick,
                  active: selected == 1,
                  onTap: () {
                    selectedType.value = 1;
                  },
                ),

                8.szW,

                _TypeButton(
                  title: LocaleKeys.permission,
                  active: selected == 2,
                  onTap: () {
                    selectedType.value = 2;
                  },
                ),

                8.szW,

                _TypeButton(
                  title: LocaleKeys.remote,
                  active: selected == 3,
                  onTap: () {
                    selectedType.value = 3;
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _typeTitle(String? type) {
    return switch (type) {
      'leave' => LocaleKeys.sick,

      'permission' => LocaleKeys.permission,

      'remote' => LocaleKeys.remote,

      _ => LocaleKeys.sick,
    };
  }
}

class _TypeButton extends StatelessWidget {
  const _TypeButton({
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
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW18,
          vertical: AppPadding.pH8,
        ),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r10),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          title,
          style: active
              ? const TextStyle().setBlackColor.s14.medium
              : const TextStyle().setMainTextColor.s14.medium,
        ),
      ),
    );
  }
}
