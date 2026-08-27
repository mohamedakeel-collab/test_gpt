part of '../imports/request_details_imports.dart';

class RequestNotesCard extends StatelessWidget {
  const RequestNotesCard({super.key, required this.requestId});

  final int requestId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => _RequestNotesBottomSheet(requestId: requestId),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pH16,
          vertical: AppPadding.pH12,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r20),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          children: [
            IconWidget(
              icon: AppAssets.svg.baseSvg.note.path,
              height: AppSize.sH24,
            ),
            12.szW,
            Text(
              LocaleKeys.notes,
              style: const TextStyle().setMainTextColor.s15.medium,
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_up_rounded,
              color: AppColors.border,
              size: AppSize.sH28,
            ),
          ],
        ),
      ),
    );
  }
}
