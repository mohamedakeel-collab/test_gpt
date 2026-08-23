part of '../imports/new_request_imports.dart';

class _RequestAttachmentField extends StatelessWidget {
  const _RequestAttachmentField({
    this.file,
    this.existingFileName,
    this.onPick,
  });

  final File? file;
  final String? existingFileName;
  final VoidCallback? onPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.uploadAttachment,
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),

        8.szH,

        Container(
          width: double.infinity,
          height: AppSize.sH120,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r12),
            border: Border.all(
              color: AppColors.border,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          child: InkWell(
            onTap: onPick,
            child: file == null && existingFileName == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: AppSize.sH35,
                        color: AppColors.icons,
                      ),

                      8.szH,

                      Text(
                        LocaleKeys.tapToAddDocument,
                        style: const TextStyle().setMainTextColor.s13.regular,
                      ),

                      4.szH,

                      Text(
                        LocaleKeys.documentHint,
                        style: const TextStyle().setHintColor.s12.regular,
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.pW12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.insert_drive_file_outlined,
                          color: AppColors.primary,
                        ),

                        8.szW,

                        Expanded(
                          child: Text(
                            file?.uri.pathSegments.last ?? existingFileName!,
                            style:
                                const TextStyle().setMainTextColor.s13.medium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
