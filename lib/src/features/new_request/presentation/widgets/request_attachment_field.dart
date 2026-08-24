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

  bool get _hasFile =>
      file != null || existingFileName != null;


  String get _fileName {
    return file?.uri.pathSegments.last ??
        existingFileName ??
        '';
  }


  String get _extension {
    return _fileName
        .split('.')
        .last
        .toLowerCase();
  }


  bool get _isImage {
    return [
      'jpg',
      'jpeg',
      'png',
      'webp',
    ].contains(_extension);
  }


  bool get _isPdf {
    return _extension == 'pdf';
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          LocaleKeys.uploadAttachment,
          style:
          const TextStyle()
              .setMainTextColor
              .s14
              .semiBold,
        ),

        8.szH,


        Container(
          width: double.infinity,

          height: AppSize.sH120,

          decoration: BoxDecoration(
            color: AppColors.white,

            borderRadius:
            BorderRadius.circular(
              AppCircular.r12,
            ),

            border: Border.all(
              color: AppColors.border,
              width: 1.5,
            ),
          ),


          child: InkWell(
            onTap: onPick,

            borderRadius:
            BorderRadius.circular(
              AppCircular.r12,
            ),


            child: !_hasFile
                ? _emptyState()

                : _filePreview(),
          ),
        ),
      ],
    );
  }


  Widget _emptyState() {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,

      children: [

        Icon(
          Icons.cloud_upload_outlined,

          size: AppSize.sH35,

          color: AppColors.icons,
        ),

        8.szH,


        Text(
          LocaleKeys.tapToAddDocument,

          style:
          const TextStyle()
              .setMainTextColor
              .s13
              .regular,
        ),


        4.szH,


        Text(
          LocaleKeys.documentHint,

          style:
          const TextStyle()
              .setHintColor
              .s12
              .regular,
        ),
      ],
    );
  }



  Widget _filePreview() {
    debugPrint(_fileName);
    debugPrint(_extension);
    if (_isImage && file != null) {

      return ClipRRect(
        borderRadius:
        BorderRadius.circular(
          AppCircular.r10,
        ),

        child: Image.file(
          file!,

          width: double.infinity,

          height: AppSize.sH120,

          fit: BoxFit.cover,
        ),
      );
    }


    return Padding(
      padding:
      EdgeInsets.symmetric(
        horizontal:
        AppPadding.pW12,
      ),

      child: Row(
        children: [

          Icon(
            _isPdf
                ? Icons.picture_as_pdf_outlined
                : Icons.insert_drive_file_outlined,

            color:
            _isPdf
                ? Colors.red
                : AppColors.primary,
          ),


          8.szW,


          Expanded(
            child: Text(
              _fileName,

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
      ),
    );
  }
}