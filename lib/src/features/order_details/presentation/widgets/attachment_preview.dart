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

  @override
  Widget build(BuildContext context) {
    final fileName =
        file?.uri.pathSegments.last ??
            existingFileName ??
            '';

    final extension =
    fileName.split('.').last.toLowerCase();


    final isImage = [
      'jpg',
      'jpeg',
      'png',
      'webp',
    ].contains(extension);


    final isPdf = extension == 'pdf';


    if (isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          AppCircular.r10,
        ),
        child: Image.network(
          existingFileUrl!,
          height: AppSize.sH120,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }


    return Row(
      children: [

        Icon(
          isPdf
              ? Icons.picture_as_pdf_outlined
              : Icons.insert_drive_file_outlined,

          color: isPdf
              ? Colors.red
              : AppColors.primary,
        ),


        8.szW,


        Expanded(
          child: Text(
            fileName,
            style:
            const TextStyle()
                .setMainTextColor
                .s13
                .medium,

            maxLines: 2,

            overflow:
            TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}