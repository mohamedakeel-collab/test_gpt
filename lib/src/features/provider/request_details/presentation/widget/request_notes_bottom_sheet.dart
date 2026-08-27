part of '../imports/request_details_imports.dart';

class _RequestNotesBottomSheet extends StatefulWidget {
  const _RequestNotesBottomSheet({required this.requestId});

  final int requestId;

  @override
  State<_RequestNotesBottomSheet> createState() =>
      _RequestNotesBottomSheetState();
}

class _RequestNotesBottomSheetState extends State<_RequestNotesBottomSheet> {
  late final RequestCommentsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = injector<RequestCommentsCubit>()..getComments(widget.requestId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestCommentsCubit>.value(
      value: _cubit,
      child: Container(
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
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),
                child: Text(
                  LocaleKeys.notes,
                  style: const TextStyle().setMainTextColor.s16.medium,
                ),
              ),
            ),
            Divider(color: AppColors.border),
            Expanded(
              child: AsyncBlocBuilder<RequestCommentsCubit, List<CommentEntity>>(
                onRetry: () => context
                    .read<RequestCommentsCubit>()
                    .getComments(widget.requestId),
                initialBuilder: (_) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      12.szH,
                      Text(
                        LocaleKeys.loadingComments,
                        style: const TextStyle().setMainTextColor.s13.medium,
                      ),
                    ],
                  ),
                ),
                loadingBuilder: (_) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      12.szH,
                      Text(
                        LocaleKeys.loadingComments,
                        style: const TextStyle().setMainTextColor.s13.medium,
                      ),
                    ],
                  ),
                ),
                builder: (context, comments) {
                  if (comments.isEmpty) {
                    return EmptyWidget(
                      title: LocaleKeys.noComments,
                      desc: LocaleKeys.errorexceptionNotcontaindesc,
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.all(AppPadding.pH16),
                    itemCount: comments.length,
                    separatorBuilder: (_, _) => 12.szH,
                    itemBuilder: (_, index) => _NoteItem(
                      comment: comments[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
                  comment.authorFullName.isEmpty
                      ? LocaleKeys.failureUnknown
                      : comment.authorFullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
            comment.comment,
            textAlign: TextAlign.start,
            style: const TextStyle().setMainTextColor.s13.regular,
          ),
        ],
      ),
    );
  }
}
