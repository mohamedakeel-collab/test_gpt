part of '../imports/request_details_imports.dart';

class _RequestNotesBottomSheet extends StatelessWidget {
  const _RequestNotesBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .85,

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppCircular.r25),

          topRight: Radius.circular(AppCircular.r25),
        ),
      ),

      child: Column(
        children: [
          12.szH,

          Container(
            width: AppSize.sW50,

            height: AppSize.sH5,

            decoration: BoxDecoration(
              color: AppColors.border,

              borderRadius: BorderRadius.circular(AppCircular.r10),
            ),
          ),

          20.szH,

          Align(
            alignment: Alignment.centerRight,

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.pH16),

              child: Text(
                'ملاحظات ',

                style: const TextStyle().setMainTextColor.s16.medium,
              ),
            ),
          ),

          Divider(color: AppColors.border),

          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppPadding.pH16),

              children: [
                _NoteItem(
                  name: 'أحمد منصور (الموظف)',

                  date: '10 أكتوبر، 09:00 ص',

                  message: 'أرجو النظر في طلبي للأهمية القصوى.',
                ),

                12.szH,

                _NoteItem(
                  name: 'المدير',

                  date: '10 أكتوبر، 11:30 ص',

                  message: 'تم استلام طلبك وسيتم الرد بعد مراجعة الجدول.',

                  isManager: true,
                ),
              ],
            ),
          ),

          Divider(color: AppColors.border),

          Padding(
            padding: EdgeInsets.all(AppPadding.pH12),

            child: Row(
              children: [
                Expanded(
                  child: DefaultTextField(
                    title: 'اكتب ملاحظتك هنا...',
                    inputType: TextInputType.multiline,
                    maxLines: 2,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppPadding.pW12,
                    ),
                    borderRadius:BorderRadius.circular(
                      AppCircular.r12,
                    ),
                    fillColor: AppColors.lightGray,
                    textAlign: TextAlign.right,
                  ),
                ),
                8.szW,
                Container(
                  width: AppSize.sW45,

                  height: AppSize.sH45,

                  decoration: BoxDecoration(
                    color: AppColors.primary,

                    borderRadius: BorderRadius.circular(AppCircular.r12),
                  ),

                  child: Icon(
                    Icons.send_outlined,

                    color: AppColors.splashBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({
    required this.name,
    required this.date,
    required this.message,
    this.isManager = false,
  });

  final String name;
  final String date;
  final String message;
  final bool isManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: isManager ? AppColors.primary.withOpacity(.08) : AppColors.fill,

        borderRadius: BorderRadius.circular(AppCircular.r10),

        border: Border.all(
          color: isManager ? AppColors.primary : AppColors.border,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(name, style: const TextStyle().setMainTextColor.s13.medium),
              Text(date, style: const TextStyle().setHintColor.s12.regular),


            ],
          ),

          8.szH,

          Text(
            message,

            textAlign: TextAlign.right,

            style: const TextStyle().setMainTextColor.s13.regular,
          ),
        ],
      ),
    );
  }
}
