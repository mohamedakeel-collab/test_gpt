part of '../imports/order_details_imports.dart';

class _RequestNotesBottomSheet extends StatelessWidget {
  const _RequestNotesBottomSheet({required this.comments});

  final List<CommentEntity> comments;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .85,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppCircular.r25),
          topRight: Radius.circular(AppCircular.r25),
        ),
      ),
      child: Column(
        children: [
          12.szH,
          Container(
            width: AppSize.sW50,
            height: AppSize.sH5,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppCircular.r10),
            ),
          ),
          20.szH,
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              LocaleKeys.notes,
              style: const TextStyle().setMainTextColor.s16.medium,
            ).paddingSymmetric(horizontal: AppPadding.pH16),
          ),
          Divider(color: AppColors.border),
          Expanded(
            child: comments.isEmpty
                ? EmptyWidget(
                    title: LocaleKeys.noComments,
                    desc: LocaleKeys.errorexceptionNotcontaindesc,
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(AppPadding.pH16),
                    itemCount: comments.length,
                    separatorBuilder: (_, _) => 12.szH,
                    itemBuilder: (_, index) =>
                        _NoteItem(comment: comments[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({required this.comment});

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppCircular.r10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  comment.authorFullName,
                  style: const TextStyle().setMainTextColor.s13.medium,
                ),
              ),
              if (comment.createdAt?.isNotEmpty ?? false)
                Text(
                  comment.createdAt!,
                  style: const TextStyle().setHintColor.s12.regular,
                ),
            ],
          ),
          8.szH,
          Text(
            comment.commentText,
            textAlign: TextAlign.start,
            style: const TextStyle().setMainTextColor.s13.regular,
          ),
        ],
      ),
    );
  }
}
