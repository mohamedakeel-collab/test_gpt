part of '../imports/add_employee_imports.dart';

class _EmployeeImagePicker extends StatelessWidget {
  const _EmployeeImagePicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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

                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: AppColors.hintText,
                  size: AppSize.sH35,
                ),
              ),

              Container(
                width: AppSize.sW25,
                height: AppSize.sH25,

                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),

                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
            ],
          ),

          8.szH,

          Text(
            LocaleKeys.uploadPersonalImage,

            style: const TextStyle().setHintColor.s12.regular,
          ),
        ],
      ),
    );
  }
}
