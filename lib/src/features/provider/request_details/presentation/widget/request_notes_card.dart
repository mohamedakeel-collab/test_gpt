part of '../imports/request_details_imports.dart';

class RequestNotesCard extends StatelessWidget {
  const RequestNotesCard({
    super.key,
    required this.requestId,
    required this.comments,
  });

  final int requestId;
  final List<CommentEntity> comments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,

          builder: (sheetContext) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),

              child: _RequestNotesBottomSheet(requestId: requestId),
            );
          },
        ).then((e) {
          if (context.mounted) {
            context.read<RequestDetailsCubit>().getRequestDetails(requestId);
          }
        });
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
