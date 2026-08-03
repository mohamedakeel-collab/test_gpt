part of '../imports/notifications_imports.dart';

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [



          16.szH,


          const _NotificationCard(
            title: 'إجازة مرضية',
            message: 'تم رفض طلب الإجازة المرضية الخاص بك.',
            time: 'أمس',
            type: NotificationType.rejected,
          ),


          12.szH,


          const _NotificationCard(
            title: 'إذن ساعي',
            message: 'تمت الموافقة على طلب الإذن الساعي الخاص بك.',
            time: 'منذ ساعتين',
            type: NotificationType.approved,
          ),


          12.szH,


          const _NotificationCard(
            title: 'إجازة سنوية',
            message: 'تمت الموافقة على طلب الإجازة السنوية الخاص بك.',
            time: '11:30 ص',
            type: NotificationType.approved,
          ),


          12.szH,


          const _NotificationCard(
            title: 'نظام TAG WINNER',
            message:
            'مرحباً بك في TAG WINNER! يسعدنا انضمامك إلينا. اكتشف ميزات إدارة الموارد البشرية الجديدة كلياً.',
            time: '14 أكتوبر',
            type: NotificationType.system,
          ),

        ],
      ).paddingSymmetric(
        horizontal: AppPadding.pH16,
      ),
    );
  }
}