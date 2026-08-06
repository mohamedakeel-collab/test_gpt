part of '../imports/request_details_imports.dart';

class _RequestReasonCard extends StatelessWidget {

  const _RequestReasonCard();


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
      EdgeInsets.all(
        AppPadding.pH12,
      ),

      decoration: BoxDecoration(

        color: AppColors.white,

        borderRadius:
        BorderRadius.circular(
          AppCircular.r12,
        ),

      ),


      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.end,

        children: [

          Text(
            'سبب الطلب',
            style: const TextStyle()
                .setMainTextColor
                .s14
                .bold,
          ),


          8.szH,


          Text(
            'أرغب في الحصول على إجازة عائلية لقضاء وقت مع الأسرة بمناسبة عطلة منتصف الفصل الدراسي.',
            textAlign: TextAlign.right,

            style: const TextStyle()
                .setMainTextColor
                .s13
                .regular,
          ),

        ],
      ),
    );
  }
}