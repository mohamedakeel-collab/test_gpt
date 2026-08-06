part of '../imports/employee_details_imports.dart';

class _EmployeeDetailsBalanceCard extends StatelessWidget {

  const _EmployeeDetailsBalanceCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });


  final String title;
  final String value;
  final String subtitle;


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

        border:
        Border.all(
          color: AppColors.border,
        ),

      ),


      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            title,
            style: const TextStyle()
                .setHintColor
                .s12
                .regular,
          ),


          8.szH,


          Text(
            value,

            style: const TextStyle()
                .setMainTextColor
                .s20
                .bold,
          ),


          Text(
            subtitle,

            style: const TextStyle()
                .setHintColor
                .s11
                .regular,
          ),

        ],
      ),
    );
  }
}