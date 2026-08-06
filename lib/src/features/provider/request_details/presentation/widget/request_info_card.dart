part of '../imports/request_details_imports.dart';

class _RequestInfoCard extends StatelessWidget {

  const _RequestInfoCard();


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

        children: [

          _InfoRow(
            title: 'نوع الطلب',
            value: 'إجازة سنوية',
            icon: Icons.calendar_today,
          ),


          Divider(
            color: AppColors.border,
          ),


          _InfoRow(
            title: 'المدة',
            value: '3 أيام',
            icon: Icons.access_time,
          ),


        ],
      ),
    );
  }
}
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(
          icon,
          size: AppSize.sH18,
          color: AppColors.brandSurface,
        ),


        8.szW,


        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [

              Text(
                title,
                style: const TextStyle()
                    .setHintColor
                    .s12
                    .regular,
              ),


              4.szH,


              Text(
                value,
                style: const TextStyle()
                    .setMainTextColor
                    .s14
                    .medium,
              ),

            ],
          ),
        ),

      ],
    );
  }
}