part of '../imports/order_details_imports.dart';

class RequestNotesCard extends StatelessWidget {
  const RequestNotesCard({super.key, required this.comments});

  final List<CommentEntity> comments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => _RequestNotesBottomSheet(comments: comments),
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
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            IconWidget(
              icon: AppAssets.svg.baseSvg.note.path,
              height: AppSize.sH24,
            ),
            12.szW,
            Text(
              LocaleKeys.notes,
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
              child: Text(
                '${comments.length}',
                style: const TextStyle().setBlackColor.s12.bold,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.border,
              size: AppSize.sH28,
            ),
          ],
        ),
      ),
    );
  }
}
