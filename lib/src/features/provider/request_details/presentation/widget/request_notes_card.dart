part of '../imports/request_details_imports.dart';

class _RequestNotesCard extends StatelessWidget {

  const _RequestNotesCard();


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


      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Icon(
            Icons.keyboard_arrow_up,
          ),


          Text(
            'ملاحظات المدير (2)',
            style: const TextStyle()
                .setMainTextColor
                .s14
                .medium,
          ),

        ],
      ),
    );
  }
}