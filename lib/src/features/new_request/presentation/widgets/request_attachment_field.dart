part of '../imports/new_request_imports.dart';

class _RequestAttachmentField extends StatelessWidget {
  const _RequestAttachmentField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'إرفاق مستند داعم',

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
            onTap: () {
              // TODO: open image picker
            },

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(
                  Icons.cloud_upload_outlined,

                  size: AppSize.sH35,

                  color: AppColors.icons,
                ),

                8.szH,

                Text(
                  'اضغط لإضافة صورة التقرير أو المستند',

                  style: const TextStyle().setMainTextColor.s13.regular,
                ),

                4.szH,

                Text(
                  'صورة التقرير أو المستند',

                  style: const TextStyle().setHintColor.s12.regular,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
