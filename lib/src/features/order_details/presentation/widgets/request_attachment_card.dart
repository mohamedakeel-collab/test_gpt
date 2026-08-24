part of '../imports/order_details_imports.dart';

class RequestAttachmentCard extends StatefulWidget {
  const RequestAttachmentCard({super.key, required this.file});

  final String? file;

  @override
  State<RequestAttachmentCard> createState() => _RequestAttachmentCardState();
}

class _RequestAttachmentCardState extends State<RequestAttachmentCard> {
  bool isExpanded = false;

  String get fileName {
    return widget.file?.split('/').last ?? '';
  }

  bool get hasFile => widget.file != null && widget.file!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: !hasFile
              ? null
              : () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },

          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pH16,
              vertical: AppPadding.pH12,
            ),

            decoration: BoxDecoration(
              color: AppColors.white,

              borderRadius: BorderRadius.circular(AppCircular.r12),

              border: Border.all(color: AppColors.border),
            ),

            child: Row(
              children: [
                IconWidget(
                  icon: AppAssets.svg.baseSvg.attachment.path,

                  height: AppSize.sH22,
                ),

                8.szW,

                Expanded(
                  child: Text(
                    hasFile ? LocaleKeys.attachments : LocaleKeys.noAttachment,

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle().setMainTextColor.s14.medium,
                  ),
                ),

                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,

                  color: hasFile ? AppColors.border : AppColors.border,

                  size: AppSize.sH28,
                ),
              ],
            ),
          ),
        ),

        if (isExpanded) ...[
          12.szH,

          AttachmentPreview(
            existingFileUrl: widget.file,
            existingFileName: fileName,
          ),
        ],
      ],
    );
  }
}
