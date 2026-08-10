part of '../imports/request_details_imports.dart';

class _RequestNotesCard extends StatelessWidget {
  const _RequestNotesCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,

          isScrollControlled: true,

          backgroundColor: Colors.transparent,

          builder: (_) {
            return const _RequestNotesBottomSheet();
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pH16,
          vertical: AppPadding.pH12,
        ),

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.circular(AppCircular.r20),

          border: Border.all(color: AppColors.border, width: 1),
        ),

        child: Row(
          children: [
            IconWidget(
              icon: AppAssets.svg.baseSvg.note.path,
              height: AppSize.sH24,
            ),

            12.szW,

            Text(
              'الملاحظات',

              style: const TextStyle().setMainTextColor.s15.medium,
            ),

            6.szW,

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW8,
                vertical: AppPadding.pH2,
              ),

              decoration: BoxDecoration(
                color: AppColors.primary,

                borderRadius: BorderRadius.circular(AppCircular.r20),
              ),

              child: Text('2', style: const TextStyle().setBlackColor.s12.bold),
            ),

            const Spacer(),

            Icon(
              Icons.keyboard_arrow_up_rounded,

              color: AppColors.border,

              size: AppSize.sH28,
            ),
          ],
        ),
      ),
    );
  }
}
