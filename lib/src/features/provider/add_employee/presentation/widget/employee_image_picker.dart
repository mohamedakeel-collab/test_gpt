part of '../imports/add_employee_imports.dart';

class _EmployeeImagePicker extends StatelessWidget {
  const _EmployeeImagePicker({
    required this.image,
    required this.onPick,
  });

  final ValueNotifier<File?> image;
  final VoidCallback onPick;


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: image,

      builder: (context, file, _) {

        return Center(
          child: GestureDetector(
            onTap: onPick,

            child: Column(
              children: [

                Stack(
                  alignment: Alignment.bottomLeft,

                  children: [

                    Container(
                      width: AppSize.sW90,
                      height: AppSize.sH90,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.fill,
                      ),

                      child: ClipOval(
                        child: file != null
                            ? Image.file(
                          file,
                          fit: BoxFit.cover,
                        )
                            : Icon(
                          Icons.add_a_photo_outlined,
                          color: AppColors.hintText,
                          size: AppSize.sH35,
                        ),
                      ),
                    ),


                    Container(
                      width: AppSize.sW25,
                      height: AppSize.sH25,

                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),

                      child:  Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),

                8.szH,

                Text(
                  LocaleKeys.uploadPersonalImage,
                  style: const TextStyle()
                      .setHintColor
                      .s12
                      .regular,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}