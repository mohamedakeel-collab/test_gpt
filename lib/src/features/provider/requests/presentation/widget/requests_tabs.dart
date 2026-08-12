part of '../imports/requests_imports.dart';

enum RequestTab {
  all,
  leaves,
  permissions,
  remote,
}


class _RequestsTabs extends StatelessWidget {
  const _RequestsTabs({
    required this.selectedTab,
  });

  final ValueNotifier<int> selectedTab;


  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<int>(
      valueListenable: selectedTab,

      builder: (context, selected, _) {

        return Row(
          children: [

            Expanded(
              child: _RequestTab(
                title: LocaleKeys.all,
                active: selected == 0,

                onTap: () {
                  selectedTab.value = 0;
                },
              ),
            ),


            8.szW,


            Expanded(
              child: _RequestTab(
                title: LocaleKeys.leaves,
                active: selected == 1,

                onTap: () {
                  selectedTab.value = 1;
                },
              ),
            ),


            8.szW,


            Expanded(
              child: _RequestTab(
                title: LocaleKeys.permissions,
                active: selected == 2,

                onTap: () {
                  selectedTab.value = 2;
                },
              ),
            ),
            8.szW,


            Expanded(
              child: _RequestTab(
                title: LocaleKeys.remote,
                active: selected == 3,

                onTap: () {
                  selectedTab.value = 3;
                },
              ),
            ),

          ],
        );
      },
    );
  }
}



class _RequestTab extends StatelessWidget {

  const _RequestTab({
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

        duration: const Duration(
          milliseconds: 200,
        ),


        padding: EdgeInsets.symmetric(
          vertical: AppPadding.pH8,
        ),


        decoration: BoxDecoration(

          color: active
              ? AppColors.primary
              : AppColors.white,


          borderRadius: BorderRadius.circular(
            AppCircular.r10,
          ),


          border: Border.all(
            color: AppColors.border,
          ),

        ),


        child: Text(

          title,

          textAlign: TextAlign.center,


          style: active

              ? const TextStyle()
              .setBlackColor
              .s13
              .medium

              : const TextStyle()
              .setMainTextColor
              .s13
              .medium,
        ),
      ),
    );
  }
}