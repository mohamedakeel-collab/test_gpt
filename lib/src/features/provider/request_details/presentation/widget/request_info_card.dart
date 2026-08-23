part of '../imports/request_details_imports.dart';

class RequestInfoCard extends StatelessWidget {
  const RequestInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              _InfoRow(
                title: 'المدة',
                value: '3 أيام',
                icon: Icons.access_time,
              ),

              _InfoRow(
                title: 'نوع الطلب',
                value: 'إجازة سنوية',
                icon: Icons.calendar_month_outlined,
              ),
            ],
          ),

          20.szH,

          _RequestDateRange(),

          20.szH,

          Text('سبب الطلب', style: const TextStyle().setMainTextColor.s14.bold),

          8.szH,

          Container(
            width: double.infinity,

            padding: EdgeInsets.all(AppPadding.pH12),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppCircular.r10),

              border: Border.all(color: AppColors.border),
            ),

            child: Text(
              'أرغب في الحصول على إجازة عائلية قصيرة لقضاء وقت مع الأبناء بمناسبة عطلة منتصف الفصل الدراسي. لقد تم التنسيق مع أعضاء الفريق لضمان عدم تأثر سير العمل خلال فترة غيابي.',

              textAlign: TextAlign.right,
              maxLines: 4,
              style: const TextStyle().setMainTextColor.s13.regular,
            ),
          ),

          20.szH,

          Divider(color: AppColors.border),

          12.szH,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                children: [
                  Icon(
                    Icons.send_outlined,
                    size: AppSize.sH18,
                    color: AppColors.icons,
                  ),

                  6.szW,

                  Text(
                    'تاريخ الإرسال: 10 أكتوبر',
                    style: const TextStyle().setHintColor.s12.regular,
                  ),
                ],
              ),

              Row(
                children: [
                  Icon(
                    Icons.gavel_outlined,
                    size: AppSize.sH18,
                    color: AppColors.icons,
                  ),

                  6.szW,

                  Text(
                    'سلطة الاعتماد: مدير الموارد البشرية',
                    style: const TextStyle().setHintColor.s12.regular,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RequestDateRange extends StatelessWidget {
  const _RequestDateRange();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(AppPadding.pH12),

      decoration: BoxDecoration(
        color: AppColors.lightGray,

        borderRadius: BorderRadius.circular(AppCircular.r10),

        border: Border(right: BorderSide(color: AppColors.border, width: 4)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'النطاق الزمني',

            style: const TextStyle().setHintColor.s12.regular,
          ),

          8.szH,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'من: 15 أكتوبر 2023',
                style: const TextStyle().setMainTextColor.s14.medium,
              ),

              Icon(Icons.arrow_forward, color: AppColors.hintText),

              Text(
                'إلى: 17 أكتوبر 2023',
                style: const TextStyle().setMainTextColor.s14.medium,
              ),
            ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(title, style: const TextStyle().setHintColor.s12.regular),

        8.szH,

        Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Icon(icon, size: AppSize.sH18, color: AppColors.brandSurface),

            6.szW,

            Text(value, style: const TextStyle().setMainTextColor.s14.medium),
          ],
        ),
      ],
    );
  }
}
