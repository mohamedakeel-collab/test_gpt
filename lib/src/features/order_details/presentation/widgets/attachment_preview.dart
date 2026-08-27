part of '../imports/order_details_imports.dart';

class AttachmentPreview extends StatelessWidget {
  const AttachmentPreview({
    super.key,
    this.file,
    this.existingFileUrl,
    this.existingFileName,
  });

  final File? file;
  final String? existingFileUrl;
  final String? existingFileName;

  String get fileName => file?.uri.pathSegments.last ?? existingFileName ?? '';

  String get extension => fileName.split('.').last.toLowerCase();

  bool get isImage => ['jpg', 'jpeg', 'png', 'webp'].contains(extension);

  bool get isPdf => extension == 'pdf';

  @override
  Widget build(BuildContext context) {
    if (isImage) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierColor: Colors.black,
            builder: (_) {
              return Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,

                child: Stack(
                  children: [
                    Center(
                      child: InteractiveViewer(
                        child: file != null
                            ? Image.file(file!, fit: BoxFit.contain)
                            : Image.network(
                                existingFileUrl!,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),

                    Positioned(
                      top: 40.h,
                      right: 20.w,

                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },

                        child: Container(
                          width: 40.w,
                          height: 40.h,

                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),

                            shape: BoxShape.circle,
                          ),

                          child:  Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              ;
            },
          );
        },

        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppCircular.r10),

          child: file != null
              ? Image.file(
                  file!,
                  height: AppSize.sH120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  existingFileUrl!,
                  height: AppSize.sH120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
      );
    }

    if (isPdf) {
      return GestureDetector(
        onTap: () {
          if (existingFileUrl != null) {
            Go.to(PdfViewerScreen(url: existingFileUrl!));
          }
        },

        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf_outlined, color: Colors.red),

            8.szW,

            Expanded(
              child: Text(
                fileName,

                style: const TextStyle().setMainTextColor.s13.medium,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,
              ),
            ),

            const Icon(Icons.open_in_new, size: 18),
          ],
        ),
      );
    }

    return Row(
      children: [
        const Icon(Icons.insert_drive_file_outlined, color: AppColors.primary),

        8.szW,

        Expanded(
          child: Text(
            fileName,

            style: const TextStyle().setMainTextColor.s13.medium,
          ),
        ),
      ],
    );
  }
}
