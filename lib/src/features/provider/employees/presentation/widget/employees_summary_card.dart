part of '../imports/employees_imports.dart';

class _EmployeesSummaryCard extends StatelessWidget {
  const _EmployeesSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH100,

      padding: EdgeInsets.all(
        AppPadding.pH16,
      ),

      decoration: BoxDecoration(
        color: AppColors.splashBackground,
        borderRadius: BorderRadius.circular(
          AppCircular.r20,
        ),
        border: Border(
          right: BorderSide(
            color: AppColors.primary,
            width: 8,
          ),
        ),
      ),

      child: Row(
        children: [
          Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [

              Text(
                'طلبات معلقة',
                style: const TextStyle()
                    .setPrimaryColor
                    .s20
                    .bold,
              ),

              12.szH,

              Text(
                'تحتاج مراجعة 24 ',
                style: const TextStyle()
                    .setWhiteColor
                    .s16
                    .medium,
              ),

            ],
          ),
          const Spacer(),
          Container(
            width: AppSize.sW70,
            height: AppSize.sH70,

            decoration: BoxDecoration(
              color: const Color(0xff5B3A00),
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.pending_actions_outlined,
              size: AppSize.sH40,
              color: Colors.orange,
            ),
          ),

        ],
      ),
    );
  }
}